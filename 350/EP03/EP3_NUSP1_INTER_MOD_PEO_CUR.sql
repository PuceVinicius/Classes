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







create table "Planeja"
(
	"ID_Pessoa" integer not null
		constraint planeja_aluno__fk
			references "Aluno",
	"Disc_ID" integer not null
		constraint planeja_disciplina__fk
			references "Disciplina_Info"
				on update cascade on delete cascade
);

create index "Planeja_Disc_ID"
	on "Planeja" ("Disc_ID");



create table "Administra"
(
	"ID_Pessoa" integer not null
		constraint administra_administrador__fk
			references "Administrador",
	"Curso" integer not null
		constraint administra_curriculo__fk
			references "Curriculo",
	"Prd" date
);

create unique index administra_adm_nusp_uindex
	on "Administrador" ("ID_Pessoa");

create table "Disciplina_Oferecimento"
(
	"Instituto" varchar(255) not null,
	"Prd" date not null,
	"Monitor" varchar(255),
	"Turma" varchar(255) not null,
	"Sala" varchar(255),
	"ID_Pessoa" integer not null
		constraint ministra_professor__fk
			references "Professor",
	"Disc_ID" integer
		constraint ministra_disciplina__fk
			references "Disciplina_Info",
    PRIMARY KEY ("Disc_ID", "ID_Pessoa", "Prd")
);

create index "Ministra_Disc_ID"
	on "Disciplina_Oferecimento" ("Disc_ID");

create index "Ministra_ID_MINISTRA"
	on "Disciplina_Oferecimento" ("ID_Pessoa");



create table "Cursa"
(
	"Status" varchar(2),
	"Nota" double precision
		constraint "Cursa_Nota_check"
			check (("Nota" >= (0)::double precision) AND ("Nota" <= (10)::double precision)),
	"Frequencia" double precision
		constraint "Cursa_Frequencia_check"
			check (("Frequencia" <= (1)::double precision) AND ("Frequencia" >= (0)::double precision)),
	"ID_Professor" integer not null
	    constraint cursa_professor__fk
			references "Aluno",
	"Disc_ID" integer not null
		constraint cursa_aluno__fk
			references "Disciplina_Info",
	"ID_Aluno" integer not null
		constraint cursa_aluno__2fk
			references "Aluno",
	"Prd" date not null,
    PRIMARY KEY ("ID_Aluno",  "Prd",  "Disc_ID",  "ID_Professor")
);


create table "Oferecimento"
(
    "ID_Professor" integer not null
        constraint ofereciment_professor__fk
			references "Professor",
    "Disc_ID" integer not null
        constraint ofereciment_disciplina__fk
			references "Disciplina_Info",
    "Prd" date not null
)
--delete


CREATE OR REPLACE FUNCTION delete_cursa (cid_pessoa INT, cDisc INT, cPRD date) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
		DELETE FROM "Cursa"
 	 	WHERE "Disc_ID" = cDISC AND "Prd" = cPRD AND "ID_Professor" = cid_pessoa;
	END;
	$$;


CREATE OR REPLACE FUNCTION delete_planeja (pid_pessoa INT, pDisc INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	DELETE FROM "Planeja"
		WHERE "ID_Pessoa" = pid_pessoa AND "Disc_ID" = pDISC;
	END;
	$$;



CREATE OR REPLACE FUNCTION delete_administra (aCurso INT, aPeriodo date, aid_pessoa INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
		DELETE FROM "Administra"
		WHERE "ID_Pessoa" = aid_pessoa AND "Curso" = aCurso AND "Prd" = aPeriodo;
	END;
	$$;



CREATE OR REPLACE FUNCTION delete_oferecimento (oid_pessoa INT, oDisc INT, oPRD date) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
		DELETE FROM "Oferecimento"
		WHERE "ID_Professor" = oid_pessoa AND "Disc_ID" = oDISC AND "Prd" = oPRD;
	END;
	$$;


CREATE OR REPLACE FUNCTION delete_do (dDisc INT, did_pessoa INT, dPRD date) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	DELETE FROM "Disciplina_Oferecimento"
		WHERE "Disc_ID" = dDISC AND "ID_Pessoa" = did_pessoa AND "Prd" = dPRD;
	END;
	$$;
--update


CREATE OR REPLACE FUNCTION update_freq_cursa (cFreq double precision, cDisc INT, cPRD date, cid_pessoa INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
		UPDATE "Cursa"
 	 	SET "Frequencia" = cFreq
		WHERE "Disc_ID" = cDisc AND "Prd" = cPRD AND "ID_Pessoa" = cid_pessoa;
	END;
	$$;

CREATE OR REPLACE FUNCTION update_nota_cursa (cNota double precision, cDisc INT, cPRD date, cid_pessoa INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
		UPDATE "Cursa"
 	 	SET "Nota" = cNota
		WHERE "Disc_ID" = cDisc AND "Prd" = cPRD AND "ID_Pessoa" = cid_pessoa;
	END;
	$$;

CREATE OR REPLACE FUNCTION update_status_cursa (cStatus varchar(2), cDisc INT, cPRD date, cid_pessoa INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
		UPDATE "Cursa"
 	 	SET "Status" = cStatus
		WHERE "Disc_ID" = cDisc AND "Prd" = cPRD AND "ID_Pessoa" = cid_pessoa;
	END;
	$$;





CREATE OR REPLACE FUNCTION update_administra (aCurso INT, aPeriodo date, aid_pessoa INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
		UPDATE "Administra"
		SET "Prd" = aPeriodo
		WHERE "ID_Pessoa" = aid_pessoa AND "Curso" = aCurso;
	END;
	$$;



CREATE OR REPLACE FUNCTION update_sala_do (dDisc INT, did_pessoa INT, dPRD date, dSala varchar(255)) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	UPDATE "Disciplina_Oferecimento"
		SET "Sala" = dSala
		WHERE "Disc_ID" = dDISC AND "ID_Professor" = did_pessoa AND "Prd" = dPRD;
	END;
	$$;

CREATE OR REPLACE FUNCTION update_turma_do (dDisc INT, did_pessoa INT, dPRD date, dTurma varchar(255)) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	UPDATE "Disciplina_Oferecimento"
		SET "Turma" = dTurma
		WHERE "Disc_ID"= dDISC AND "ID_Professor" = did_pessoa AND "Prd" = dPRD;
	END;
	$$;

CREATE OR REPLACE FUNCTION update_monitor_do (dDisc INT, did_pessoa INT, dPRD date, dMntr varchar(255)) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	UPDATE "Disciplina_Oferecimento"
		SET "Monitor" = dMntr
		WHERE "Disc_ID" = dDISC AND "ID_Professor" = did_pessoa AND "Prd" = dPRD;
	END;
	$$;

CREATE OR REPLACE FUNCTION update_instituto_do (dDisc INT, did_pessoa INT, dPRD date, dInsti varchar(255)) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	UPDATE "Disciplina_Oferecimento"
		SET "Instituto" = dInsti
		WHERE "Disc_ID" = dDISC AND "ID_Professor" = did_pessoa AND "Prd" = dPRD;
	END;
	$$;
--insert


CREATE OR REPLACE FUNCTION insert_cursa (cStatus varchar(2), cNota double precision, cFreq double precision, cid_prof INT, cDisc INT, cPRD date, cid_aluno INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	INSERT INTO "Cursa" ("Status", "Nota", "Frequencia", "ID_Professor", "Disc_ID", "Prd", "ID_Aluno")
		VALUES (cStatus, cNota, cFreq, cid_prof, cDisc, cPRD, cid_aluno);
	END;
	$$;


CREATE OR REPLACE FUNCTION insert_planeja (pid_pessoa INT, pDisc INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	INSERT INTO "Planeja" ("ID_Pessoa", "Disc_ID")
		VALUES (pid_pessoa, pDISC);
	END;
	$$;



CREATE OR REPLACE FUNCTION insert_administra (aCurso INT, aPeriodo date, aNUSP INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
		INSERT INTO "Administra" ("ID_Pessoa", "Curso", "Prd")
		VALUES (aNUSP, aCurso, aPeriodo);
	END;
	$$;


CREATE OR REPLACE FUNCTION insert_oferecimento (oid_pessoa INT, oDisc INT, oPRD date) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
		INSERT INTO "Oferecimento" ("ID_Professor", "Disc_ID", "Prd")
		VALUES (oid_pessoa, oDISC, oPRD);
	END;
	$$;

CREATE OR REPLACE FUNCTION insert_do (dDisc INT, did_pessoa INT, dPRD date, dSala varchar(255), dTurma varchar(255), dMntr varchar(255), dInsti varchar(255)) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	INSERT INTO "Disciplina_Oferecimento" ("Disc_ID", "ID_Pessoa", "Prd", "Sala", "Turma", "Monitor", "Instituto")
    VALUES (dDISC, did_pessoa, dPRD, dSala, dTurma, dMntr, dInsti);
	END;
	$$;
--retrival
CREATE OR REPLACE FUNCTION retrieve_status_cursa (cid_pessoa INT, cDisc INT, cPRD date) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
		RETURN(SELECT ("ID_Aluno", "Status")
					FROM "Cursa"
					WHERE ("ID_Professor" = cid_pessoa AND "Disc_ID" = cDisc AND "Prd" = cPRD
		));
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_reprovados_cursa (cid_pessoa INT, cDisc INT, cPRD date) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
		RETURN(SELECT "ID_Aluno"
					FROM "Cursa"
					WHERE ("ID_Professor" = cid_pessoa AND "Disc_ID" = cDisc AND "Prd" = cPRD AND ("Status" = 'RA' OR "Status" = 'RN' OR "Status" = 'RF')
		));
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_aprovados_cursa (cid_pessoa INT, cDisc INT, cPRD date) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
		RETURN(SELECT ("ID_Aluno", "Nota")
					FROM "Cursa"
					WHERE ("ID_Professor" = cid_pessoa AND "Disc_ID" = cDisc AND "Prd" = cPRD AND "Status" = 'A'
		));
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_inscritos_cursa (cid_pessoa INT, cDisc INT, cPRD date) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
		RETURN(SELECT "ID_Aluno"
					FROM "Cursa"
					WHERE ("ID_Professor" = cid_pessoa AND "Disc_ID" = cDisc AND "Prd" = cPRD AND "Status" = 'I'
		));
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_matriculados_cursa (cid_pessoa INT, cDisc INT, cPRD date) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
		RETURN(SELECT "ID_Aluno"
					FROM "Cursa"
					WHERE ("ID_Professor" = cid_pessoa AND "Disc_ID" = cDisc AND "Prd" = cPRD AND "Status" = 'MA'
		));
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_freqs_cursa (cid_pessoa INT, cDisc INT, cPRD date) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
		RETURN(SELECT ("Frequencia", "ID_Aluno")
					FROM "Cursa"
					WHERE ("ID_Professor" = cid_pessoa AND "Disc_ID" = cDisc AND "Prd" = cPRD
		));
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_id_pessoa_planeja (pDisc INT) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	RETURN (SELECT "ID_Pessoa" FROM "Planeja" WHERE "Disc_ID" = pDISC );
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_discprof_prd_o (oPRD date) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
		RETURN (SELECT ("Disc_ID", "ID_Professor") FROM "Oferecimento" WHERE "Prd" = oPRD);
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_prof_prd_o (oPRD date) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
		RETURN (SELECT "ID_Professor" FROM "Oferecimento" WHERE "Prd" = oPRD);
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_disc_prd_o (oPRD date) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
		RETURN (SELECT "Disc_ID" FROM "Oferecimento" WHERE "Prd" = oPRD);
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_prof_disc_o (oDisc INT) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
		RETURN (SELECT "ID_Professor" FROM "Oferecimento" WHERE "Disc_ID" = oDisc);
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_prd_disc_o (oDisc INT) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
		RETURN (SELECT "Prd" FROM "Oferecimento" WHERE "Disc_ID" = oDisc);
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_disc_prof_o (oid_pessoa INT) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
		RETURN (SELECT "Disc_ID" FROM "Oferecimento" WHERE "ID_Professor" = oid_pessoa);
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_sala_do (dDisc INT, did_pessoa INT, dPRD date) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	RETURN (SELECT "Sala" FROM "Disciplina_Oferecimento" WHERE ("Disc_ID" = dDISC AND "ID_Pessoa" = did_pessoa AND "Prd" = dPRD));
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_turma_do (dDisc INT, did_pessoa INT, dPRD date) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	RETURN (SELECT "Turma" FROM "Disciplina_Oferecimento" WHERE ("Disc_ID" = dDISC AND "ID_Pessoa" = did_pessoa AND "Prd" = dPRD));
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_monitor_do (dDisc INT, did_pessoa INT, dPRD date) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	RETURN (SELECT "Monitor" FROM "Disciplina_Oferecimento" WHERE ("Disc_ID" = dDISC AND "ID_Pessoa" = did_pessoa AND "Prd" = dPRD));
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_instituto_do (dDisc INT, did_pessoa INT, dPRD date) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	RETURN (SELECT "Instituto" FROM "Disciplina_Oferecimento" WHERE ("Disc_ID" = dDISC AND "ID_Pessoa" = did_pessoa AND "Prd" = dPRD));
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_monitores_do (dDisc INT) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	RETURN (SELECT "Monitor" FROM "Disciplina_Oferecimento" WHERE "Disc_ID" = dDISC);
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_salas_do (dDisc INT) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	RETURN (SELECT "Sala" FROM "Disciplina_Oferecimento" WHERE "Disc_ID" = dDISC);
	END;
	$$;
