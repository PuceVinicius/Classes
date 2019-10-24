create function cpf_validar(par_cpf character varying) returns integer
	language plpgsql
as $$
DECLARE
        x real;
        y real;
        soma integer;
        dig1 integer;
        dig2 integer;
        len integer;
        contloop integer;
        val_par_cpf varchar(11);
    BEGIN
        IF char_length(par_cpf) = 11 THEN
        ELSE
            RAISE NOTICE 'Formato inv�lido: %',$1;
            RETURN 0;
        END IF;
        x := 0;
        soma := 0;
        dig1 := 0;
        dig2 := 0;
        contloop := 0;
        val_par_cpf := $1;
        len := char_length(val_par_cpf);
        x := len -1;

        contloop :=1;
        WHILE contloop <= (len -2) LOOP
            y := CAST(substring(val_par_cpf from contloop for 1) AS NUMERIC);
            soma := soma + ( y * x);
            x := x - 1;
            contloop := contloop +1;
        END LOOP;
        dig1 := 11 - CAST((soma % 11) AS INTEGER);
        if (dig1 = 10) THEN dig1 :=0 ; END IF;
        if (dig1 = 11) THEN dig1 :=0 ; END IF;


        x := 11; soma :=0;
        contloop :=1;
        WHILE contloop <= (len -1) LOOP
            soma := soma + CAST((substring(val_par_cpf FROM contloop FOR 1)) AS REAL) * x;
            x := x - 1;
            contloop := contloop +1;
        END LOOP;
        dig2 := 11 - CAST ((soma % 11) AS INTEGER);
        IF (dig2 = 10) THEN dig2 := 0; END IF;
        IF (dig2 = 11) THEN dig2 := 0; END IF;
        --Teste do CPF
        IF ((dig1 || '' || dig2) = substring(val_par_cpf FROM len-1 FOR 2)) THEN
            RETURN 1;
        ELSE
            RAISE NOTICE 'DV do CPF Inv�lido: %',$1;
            RETURN 0;
        END IF;
    END;
$$;

create table "Pessoa"
(
	"ID_Pessoa" integer not null
		constraint "Pessoa_pkey"
			primary key,
	"CPF" text not null
		constraint "Pessoa_CPF_check"
			check (cpf_validar(("CPF")::character varying) = 1),
	"Nome" varchar(255) not null,
	us_id integer
		constraint us_pf_usuario__fk
			references "User"
				on update cascade on delete cascade
);


create table "Administrador"
(
	"NUSP" integer not null
		constraint check_nusp
			check (("NUSP" > 0) AND ("NUSP" < 999999999)),
	"Perfil" integer not null,
	"ID_Pessoa" integer not null
		constraint "Administrador_pkey"
			primary key
		constraint administrador_pessoa__fk
			references "Pessoa"
);

create unique index administrador_id_pessoa_uindex
	on "Administrador" ("ID_Pessoa");

create table "Aluno"
(
	"NUSP" integer not null
		constraint "Aluno_NUSP_check"
			check (("NUSP" > 0) AND ("NUSP" <= 999999999)),
	"Curso" integer not null
	    constraint "Aluno_Curso__fk"
	        references "Curriculo",
	"ID_Pessoa" integer not null
		constraint "Aluno_pkey"
			primary key
		constraint aluno_pessoa__fk
			references "Pessoa"
);

create unique index aluno_id_pessoa_uindex
	on "Aluno" ("ID_Pessoa");

create table "Professor"
(
	"NUSP" integer not null
		constraint "Professor_NUSP_check"
			check (("NUSP" > 0) AND ("NUSP" <= 999999999)),
	"ID_Pessoa" integer not null
		constraint "Professor_pkey"
			primary key
		constraint professor_pessoa__fk
			references "Pessoa",
	"Especializacao" varchar(255)
);

create unique index professor_id_pessoa_uindex
	on "Professor" ("ID_Pessoa");

--delete

CREATE OR REPLACE FUNCTION delete_aluno (aNUSP INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
		DELETE FROM "Aluno"
		WHERE "NUSP" = aNUSP;
	END;
	$$;

CREATE OR REPLACE FUNCTION delete_professor (pNUSP INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
		DELETE FROM "Professor"
		WHERE "NUSP" = pNUSP;
	END;
	$$;

CREATE OR REPLACE FUNCTION delete_admin (aid_pessoa INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
		DELETE FROM "Administrador"
		WHERE "ID_Pessoa" = aid_pessoa;
	END;
	$$;

CREATE OR REPLACE FUNCTION delete_pessoa (pid_pessoa INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	DELETE FROM "Pessoa"
		WHERE "ID_Pessoa" = pid_pessoa;
	END;
	$$;

--update

CREATE OR REPLACE FUNCTION update_aluno (aNUSP INT, aCurso INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
		UPDATE "Aluno"
		SET "Curso" = aCurso
		WHERE "NUSP" = aNUSP;
	END;
	$$;

CREATE OR REPLACE FUNCTION update_professor (pEspec varchar(255), pNUSP INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
		UPDATE "Professor"
		SET "Especializacao" = pEspec
		WHERE "NUSP" = pNUSP;
	END;
	$$;

CREATE OR REPLACE FUNCTION update_admin (aid_pessoa INT, aPerfil INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
		UPDATE "Administrador"
		SET "Perfil" = aPerfil
		WHERE "ID_Pessoa" = aid_pessoa;
	END;
	$$;

CREATE OR REPLACE FUNCTION update_nome_pessoa (pid_pessoa INT, pNome varchar(255)) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	UPDATE "Pessoa"
		SET "Nome" = pNome
		WHERE "ID_Pessoa" = pid_pessoa;
	END;
	$$;

CREATE OR REPLACE FUNCTION update_cpf_pessoa (pid_pessoa INT, pCPF text) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	UPDATE "Pessoa"
		SET "CPF" = pCPF
		WHERE "ID_Pessoa" = pid_pessoa;
	END;
	$$;

--insert
CREATE OR REPLACE FUNCTION insert_aluno (aid_pessoa INT, aCurso INT, aNUSP INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
		INSERT INTO "Aluno" ("NUSP", "Curso", "ID_Pessoa")
		VALUES (aNUSP, aCurso, aid_pessoa);
	END;
	$$;

CREATE OR REPLACE FUNCTION insert_professor (pid_pessoa INT, pEspec varchar(255), pNUSP INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
		INSERT INTO "Professor" ("NUSP", "ID_Pessoa", "Especializacao")
		VALUES (pNUSP,pid_pessoa,pEspec);
	END;
	$$;

CREATE OR REPLACE FUNCTION insert_admin (aid_pessoa INT, aPerfil INT, aNUSP INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
		INSERT INTO "Administrador" ("NUSP", "Perfil", "ID_Pessoa")
		VALUES (aNUSP, aPerfil, aid_pessoa);
	END;
	$$;

CREATE OR REPLACE FUNCTION insert_pessoa (pid_pessoa INT, pNome varchar(255), pCPF text, pus_id INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	INSERT INTO "Pessoa" ("ID_Pessoa", "CPF", "Nome", us_id)
    	VALUES (pid_pessoa, pCPF, pNome, pus_id);
	END;
	$$;
--retrival
CREATE OR REPLACE FUNCTION retrieve_aluno (aid_pessoa INT) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
		RETURN (SELECT ("NUSP", "Curso")
						FROM "Aluno"
						WHERE "ID_Pessoa" = aid_pessoa);
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_professor (pNUSP INT) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
		RETURN (SELECT "Especializacao" FROM "Professor" WHERE "NUSP" = pNUSP);
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_admin (aid_pessoa INT) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
		RETURN (SELECT ("NUSP", "Perfil")
			FROM "Administrador"
			WHERE "ID_Pessoa" = aid_pessoa);
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_nome_pessoa (pid_pessoa INT) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	RETURN (SELECT "Nome" FROM "Pessoa" WHERE "ID_Pessoa" = pid_pessoa);
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_usid_pessoa (pid_pessoa INT) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	RETURN (SELECT us_id FROM "Pessoa" WHERE "ID_Pessoa" = pid_pessoa);
	END;
	$$;
