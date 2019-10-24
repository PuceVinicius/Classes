create table "User"
(
	us_id integer not null
		constraint "Usuario_pkey"
			primary key,
	us_email varchar(255) not null,
	us_password varchar(255) not null
);

create table "Servico"
(
	"ID_Servico" integer not null
		constraint "Servico_pkey"
			primary key
		constraint "servico_ID_Servico_check"
			check (("ID_Servico" >= 0) AND ("ID_Servico" <= 99)),
	"Desc" varchar(255),
	"Nome" varchar(255)
);

create index "Servico_ID_"
	on "Servico" ("ID_Servico");

create table pf_se
(
	"Perfil" integer not null
		constraint pf_se_perfil__fk
			references "Perfil"
				on update cascade on delete cascade,
	"ID_Servico" integer not null
		constraint pf_se_servico__fk
			references "Servico"
);

create table us_pf
(
	us_id integer not null
		constraint us_pf_usuario__fk
			references "User"
				on update cascade on delete cascade,
	"Perfil" integer not null
		constraint us_pf_perfil__fk
			references "Perfil"
);

create table "Perfil"
(
	"Perfil" integer not null
		constraint "Perfil_pkey"
			primary key,
	"Nome" varchar(255)
);


create index "Perfil_PERFIL"
	on "Perfil" ("Perfil");


--delete

CREATE OR REPLACE FUNCTION delete_usuario (uus_id INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	DELETE FROM "User"
    WHERE us_id = uus_id;
	END;
	$$;

CREATE OR REPLACE FUNCTION delete_us_pf (uus_id INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	DELETE FROM us_pf
    WHERE us_id = uus_id;
	END;
	$$;

CREATE OR REPLACE FUNCTION delete_pf_se (pPerfil INT, pServico INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	DELETE FROM pf_se
    WHERE "Perfil" = pPerfil AND "ID_Servico" = pServico;
	END;
	$$;

CREATE OR REPLACE FUNCTION delete_servico (sServico INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	DELETE FROM "Servico"
    WHERE "ID_Servico" = sServico;
	END;
	$$;

CREATE OR REPLACE FUNCTION delete_perfil (pPerfil INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
		DELETE FROM "Perfil"
		WHERE "Perfil" = pPerfil;
	END;
	$$;

--insert

CREATE OR REPLACE FUNCTION insert_usuario (uus_id INT, uSenha varchar(255), uEmail varchar(255)) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	INSERT INTO "User" (us_id, us_password, us_email)
    	VALUES (uus_id, uSenha, uEmail);
	END;
	$$;

CREATE OR REPLACE FUNCTION insert_us_pf (uus_id INT, pPerfil INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	INSERT INTO us_pf (us_id, "Perfil")
    	VALUES (uus_id, pPerfil);
	END;
	$$;

CREATE OR REPLACE FUNCTION insert_pf_se (pPerfil INT, pServico INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	INSERT INTO pf_se ("Perfil", "ID_Servico")
    	VALUES (pPerfil, pServico);
	END;
	$$;

CREATE OR REPLACE FUNCTION insert_servico (sServico INT, sDesc varchar(255), sNome varchar(255)) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	INSERT INTO "Servico" ("ID_Servico", "Desc", "Nome")
    VALUES (sServico, sDesc, sNome);
	END;
	$$;

CREATE OR REPLACE FUNCTION insert_perfil (pPerfil INT, pNome varchar(255)) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	INSERT INTO "Perfil" ("Perfil", "Nome")
    	VALUES (pPerfil, pNome);
	END;
	$$;

--update
CREATE OR REPLACE FUNCTION update_usuario (uus_id INT, uSenha varchar(255), uEmail varchar(255)) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	UPDATE "User"
    SET us_password = uSenha, us_email = uEmail
    WHERE us_id = uus_id;
	END;
	$$;

CREATE OR REPLACE FUNCTION update_us_pf (uus_id INT, pPerfil INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	UPDATE us_pf
		SET "Perfil" = pPerfil
    WHERE us_id = uus_id;
	END;
	$$;

CREATE OR REPLACE FUNCTION update_servico (sServico INT, sDesc varchar(255), sNome varchar(255)) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	UPDATE "Servico"
		SET "Desc" = sDesc, "Nome" = sNome
    WHERE "ID_Servico" = sServico;
	END;
	$$;

--retrival
CREATE OR REPLACE FUNCTION retrieve_usuario (uus_id INT) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	RETURN(SELECT us_email FROM "User" WHERE us_id = uus_id);
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_perfil (pPerfil INT) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	RETURN (SELECT "Nome" FROM "Perfil" WHERE "Perfil" = pPerfil);
	END;
	$$;


CREATE OR REPLACE FUNCTION retrieve_perfil_us_pf (uus_id INT) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	RETURN (SELECT "Perfil" FROM us_pf WHERE us_id = uus_id);
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_us_id_us_pf (pPerfil INT) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	RETURN (SELECT us_id FROM us_pf WHERE "Perfil" = pPerfil);
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_servico_pf_se (pPerfil INT) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	RETURN (SELECT "ID_Servico"
			 			FROM pf_se
						WHERE "Perfil" = pPerfil);
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_perfis_pf_se (pServico INT) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	RETURN (SELECT "Perfil" FROM pf_se WHERE "ID_Servico" = pServico);
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_servico (sServico INT) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	RETURN (SELECT ("Nome", "Desc") FROM "Servico" WHERE "ID_Servico" = sServico);
	END;
	$$;
