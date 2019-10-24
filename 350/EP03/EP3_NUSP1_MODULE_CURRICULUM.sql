create table "Curriculo"
(
	"Curso" integer not null
		constraint "Curriculo_pkey"
			primary key,
	"Nome" varchar(20) not null
);

create index "Curriculo_CURSO"
	on "Curriculo" ("Curso");



create table "Trilha"
(
	"ID_Trilha" integer not null
		constraint "Trilha_pkey"
			primary key,
	"Nome" varchar(255) not null
);

create index "Trilha_ID_Trilha"
	on "Trilha" ("ID_Trilha");

create table "Rel_Cur_Tri"
(
	"Curso" integer not null
		constraint "Rel_Cur_Tri_curriculo__fk"
			references "Curriculo"
				on update cascade on delete cascade,
	"ID_Trilha" integer not null
		constraint Rel_Cur_Tri_trilha__fk
			references "Trilha"
);


create index "Rel_Cur_Tri_ID"
	on "Rel_Cur_Tri" ("Curso");

create index "Rel_Cur_Tri_ID_Trilha"
	on "Rel_Cur_Tri" ("ID_Trilha");

create table "Disciplina_Info"
(
	"Disc_ID" integer not null
		constraint "Disciplina_pkey"
			primary key,
	"Desc" varchar(255) not null,
	"CR_A" integer not null,
	"CR_T" integer not null,
	"Nome" varchar(255) not null
);

create table "Modulo"
(
	"Nome" varchar(255) not null,
	"ID_Modulo" integer not null
		constraint "Modulo_pkey"
			primary key,
	"ID_Trilha" integer not null
        constraint "Modulo_fkey"
            references "Trilha"
);

create index "Modulo_ID_Trilha"
	on "Modulo" ("ID_Trilha");

create index "Modulo_ID_Modulo"
	on "Modulo" ("ID_Modulo");

create table "Rel_Dis_Mod"
(
	"ID_Modulo" integer not null
		constraint rel_dis_mod_modulo__fk
			references "Modulo"
				on update cascade on delete cascade,
	"Disc_ID" integer not null
		constraint rel_dis_mod_disciplina__fk
			references "Disciplina_Info",
	"Nat" char not null
		constraint rel_dis_mod_nat_check
			check ("Nat" = ANY (ARRAY['O'::bpchar, 'E'::bpchar, 'L'::bpchar, 'X'::bpchar]))
);

create table "Periodo_Curriculo"
(
	"Curso" integer not null
		constraint periodo_curriculo_curriculo__fk
			references "Curriculo",
	"Prd" date
);

create table "Disciplinas_Rel_Cur_Tri"
(
	"Curso" integer not null
		constraint disciplinas_rel_cur_tri_curriculo__fk
			references "Curriculo",
	"ID_Trilha" integer not null
		constraint disciplinas_rel_cur_tri_trilha__fk
			references "Trilha",
    "Disc_ID" integer not null
        constraint disciplinas_rel_cur_tri_disciplina__fk
            references "Disciplina_Info"
);

create table "Grade_Curriculo"
(
	"Curso" integer not null
		constraint grade_curriculo_curriculo_curso_fk
			references "Curriculo"
				on update cascade on delete cascade,
	"Disc_ID" integer not null
);

create table "Periodo_Disciplina"
(
	"Disc_ID" integer not null
		constraint grade_curriculo_disciplina__fk
			references "Disciplina_Info",
	"Prd" date
);

create table "Prereq_Rel_Dis_Mod"
(
	"ID_Modulo" integer not null
		constraint prereq_rel_dis_mod_modulo__fk
			references "Modulo",
	"Disc_ID" integer not null
		constraint grade_curriculo_disciplina__fk
			references "Disciplina_Info",
	"Prereq" varchar
);

--delete
CREATE OR REPLACE FUNCTION delete_modulo (mid_modulo INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	DELETE FROM "Modulo"
    WHERE "ID_Modulo" = mID_modulo;
	END;
	$$;

CREATE OR REPLACE FUNCTION delete_curriculo (cCURSO INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	DELETE FROM "Curriculo"
		WHERE "Curso" = cCurso;
	END;
	$$;

CREATE OR REPLACE FUNCTION delete_grade_curriculo (cCURSO INT, cDisc INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	DELETE FROM "Grade_Curriculo"
    WHERE "Curso" = cCURSO AND "Disc_ID" = cDISC;
	END;
	$$;

CREATE OR REPLACE FUNCTION delete_periodo_curriculo (cCURSO INT, cPRD date) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	DELETE FROM "Periodo_Curriculo"
    WHERE "Curso"= cCURSO AND "Prd" = cPRD;
	END;
	$$;

CREATE OR REPLACE FUNCTION delete_trilha (tid_trilha INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	DELETE FROM "Trilha"
    WHERE "ID_Trilha" = tID_trilha;
	END;
	$$;

CREATE OR REPLACE FUNCTION delete_rel_cur_tri (rCurso INT, rid_trilha INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
		DELETE FROM "Rel_Cur_Tri"
		WHERE "Curso" = rCurso AND "ID_Trilha" = rID_trilha;
	END;
	$$;

CREATE OR REPLACE FUNCTION delete_drel_cur_tri (rCurso INT, rID_trilha INT, rDisc INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
		DELETE FROM "Disciplinas_Rel_Cur_Tri"
		WHERE "Curso" = rCurso AND "ID_Trilha" = rID_trilha AND "Disc_ID" = rDISC;
	END;
	$$;

CREATE OR REPLACE FUNCTION delete_di (dDisc INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	DELETE FROM "Disciplina_Info"
		WHERE "Disc_ID" = dDISC;
	END;
	$$;

CREATE OR REPLACE FUNCTION delete_rel_dis_mod (dDisc INT, dMOD INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	DELETE FROM "Rel_Dis_Mod"
		WHERE "Disc_ID" = dDISC AND "ID_Modulo" = dMOD;
	END;
	$$;

CREATE OR REPLACE FUNCTION delete_prereq (dDisc INT, dMOD INT, PREREQ varchar) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	DELETE FROM "Prereq_Rel_Dis_Mod"
		WHERE "Disc_ID" = dDISC AND "ID_Modulo" = dMOD AND "Prereq" = PREREQ;
	END;
	$$;
--update
CREATE OR REPLACE FUNCTION update_modulo (mid_modulo INT, mid_trilha INT, mNome varchar(255)) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
		UPDATE "Modulo"
 	 	SET "Nome" = mNome, "ID_Trilha" = mID_triha
    WHERE "ID_Modulo" = mID_modulo;
	END;
	$$;

CREATE OR REPLACE FUNCTION update_trilha (tid_trilha INT, tNome varchar(255)) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	UPDATE "Trilha"
    SET "Nome" = tNome
		WHERE "ID_Trilha" = tID_trilha;
	END;
	$$;

  CREATE OR REPLACE FUNCTION update_creditos_di (dDisc INT, CR_A INT, CR_T INT) returns void
  	LANGUAGE plpgsql
  	AS $$
  	BEGIN
   	 	UPDATE "Disciplina_Info"
  		SET "CR_A" = CR_A, "CR_T" = CR_T
  		WHERE "Disc_ID" = dDISC;
  	END;
  	$$;

  CREATE OR REPLACE FUNCTION update_nome_di (dDisc INT, dNome CHAR(255)) returns void
  	LANGUAGE plpgsql
  	AS $$
  	BEGIN
   	 	UPDATE "Disciplina_Info"
  		SET "Nome" = dNome
  		WHERE "Disc_ID" = dDISC;
  	END;
  	$$;

CREATE OR REPLACE FUNCTION update_desc_di (dDisc INT, dDESC CHAR(255)) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	UPDATE "Disciplina_Info"
		SET "Desc" = dDESC
		WHERE "Disc_ID" = dDISC;
	END;
	$$;

CREATE OR REPLACE FUNCTION update_rel_dis_mod (dDisc INT, dMOD INT, dNAT CHAR(255)) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	UPDATE "Rel_Dis_Mod"
		SET "Nat" = dNAT
		WHERE "Disc_ID" = dDISC AND "ID_Modulo" = dMOD;
	END;
	$$;

CREATE OR REPLACE FUNCTION update_prereq (dDisc INT, dMOD INT, PREREQ varchar) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	UPDATE "Prereq_Rel_Dis_Mod"
		SET "Prereq" = PREREQ
		WHERE "Disc_ID" = dDISC AND "ID_Modulo" = dMOD;
	END;
	$$;
---insert
CREATE OR REPLACE FUNCTION insert_modulo (mid_modulo INT, mid_trilha INT, mNome varchar(255)) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	INSERT INTO "Modulo" ("Nome", "ID_Modulo", "ID_Trilha")
    VALUES (mNome, mID_modulo, mID_trilha);
	END;
	$$;

CREATE OR REPLACE FUNCTION insert_curriculo (cCURSO INT, cNOME varchar(20)) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	INSERT INTO "Curriculo" ("Curso", "Nome")
    	VALUES (cCURSO, cNOME);
	END;
	$$;

CREATE OR REPLACE FUNCTION insert_grade_curriculo (cCURSO INT, cDisc INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	INSERT INTO "Grade_Curriculo" ("Curso", "Disc_ID")
    	VALUES (cCURSO, cDISC);
	END;
	$$;

CREATE OR REPLACE FUNCTION insert_periodo_curriculo (cCURSO INT, cPRD date) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	INSERT INTO "Periodo_Curriculo" ("Curso", "Prd")
    VALUES (cCURSO, cPRD);
	END;
	$$;

CREATE OR REPLACE FUNCTION insert_trilha (tID_trilha INT, tNome varchar(255)) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	INSERT INTO "Trilha" ("ID_Trilha", "Nome")
    VALUES (tID_trilha, tNome);
	END;
	$$;

CREATE OR REPLACE FUNCTION insert_rel_cur_tri (rCurso INT, rID_trilha INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
		INSERT INTO "Rel_Cur_Tri" ("Curso", "ID_Trilha")
		VALUES (rCurso, rID_trilha);
	END;
	$$;

CREATE OR REPLACE FUNCTION insert_rel_cur_tri (rCurso INT, rID_trilha INT, rDisc INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
		INSERT INTO "Disciplinas_Rel_Cur_Tri" ("Curso", "ID_Trilha", "Disc_ID")
		VALUES (rCurso, rID_trilha, rDISC);
	END;
	$$;

CREATE OR REPLACE FUNCTION insert_di (dDisc INT, CR_A INT, CR_T INT, dDESC CHAR(255), dNome CHAR(255)) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	INSERT INTO "Disciplina_Info" ("Disc_ID", "CR_A", "CR_T", "Desc", "Nome")
    VALUES (dDISC, CR_A, CR_T, dDESC, dNome);
	END;
	$$;

CREATE OR REPLACE FUNCTION insert_rel_dis_mod (dDisc INT, dMOD INT, dNAT CHAR(255)) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	INSERT INTO "Rel_Dis_Mod" ("Disc_ID","ID_Modulo", "Nat")
    VALUES (dDISC, dMOD, dNAT);
	END;
	$$;

CREATE OR REPLACE FUNCTION insert_prereq (dDisc INT, dMOD INT, prereq varchar) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	INSERT INTO "Prereq_Rel_Dis_Mod" ("Disc_ID", "ID_Modulo", "Prereq")
    VALUES (dDISC, dMOD, prereq);
	END;
	$$;
--retrival
CREATE OR REPLACE FUNCTION retrieve_nome_trilha (tid_trilha INT) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	RETURN(SELECT "Nome" FROM "Trilha" WHERE "ID_Trilha" = tID_trilha);
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_allnomes_trilha (tNome varchar(255)) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	RETURN(SELECT "ID_Trilha" FROM "Trilha" WHERE "Nome" = tNome);
	END;
	$$;
CREATE OR REPLACE FUNCTION retrieve_cursos_rel_cur_tri (rid_trilha INT) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
		RETURN (SELECT "Curso" FROM "Rel_Cur_Tri" WHERE "ID_Trilha" = rID_trilha);
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_trilhas_rel_cur_tri (rCurso INT) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
		RETURN (SELECT "ID_Trilha" FROM "Rel_Cur_Tri" WHERE "Curso" = rCurso);
	END;
	$$;
CREATE OR REPLACE FUNCTION retrieve_ctdisc_drel_cur_tri (rCurso INT, rID_trilha INT) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
		RETURN (SELECT "Disc_ID" FROM "Disciplinas_Rel_Cur_Tri" WHERE ("Curso" = rCurso AND "ID_Trilha" = rID_trilha));
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_tdisc_drel_cur_tri (rID_trilha INT) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
		RETURN (SELECT "Disc_ID" FROM "Disciplinas_Rel_Cur_Tri" WHERE "ID_Trilha" = rID_trilha);
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_cdisc_drel_cur_tri (rCurso INT) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
		RETURN (SELECT "Disc_ID" FROM "Disciplinas_Rel_Cur_Tri" WHERE "Curso" = rCurso);
	END;
	$$;
  CREATE OR REPLACE FUNCTION retrieve_creditos_di (dDisc INT) returns text
  	LANGUAGE plpgsql
  	AS $$
  	BEGIN
   	 	RETURN (SELECT ("CR_A", "CR_T") FROM "Disciplina_Info" WHERE "Disc_ID" = dDISC);
  	END;
  	$$;

  CREATE OR REPLACE FUNCTION retrieve_nomedesc_di (dDisc INT) returns text
  	LANGUAGE plpgsql
  	AS $$
  	BEGIN
   	 	RETURN (SELECT ("Nome", "Desc") FROM "Disciplina_Info" WHERE "Disc_ID" = dDISC);
  	END;
  	$$;

  CREATE OR REPLACE FUNCTION retrieve_di (dDisc INT) returns text
  	LANGUAGE plpgsql
  	AS $$
  	BEGIN
   	 	RETURN (SELECT ("CR_A", "CR_T", "Desc", "Nome") FROM "Disciplina_Info" WHERE "Disc_ID" = dDISC);
  	END;
  	$$;






  CREATE OR REPLACE FUNCTION retrieve_nat_rel_dis_mod (dNAT varchar(255)) returns text
  	LANGUAGE plpgsql
  	AS $$
  	BEGIN
   	 	RETURN (SELECT "Disc_ID" FROM "Rel_Dis_Mod" WHERE "Nat" = dNAT);
  	END;
  	$$;

  CREATE OR REPLACE FUNCTION retrieve_discmod_rel_dis_mod (dMOD INT) returns text
  	LANGUAGE plpgsql
  	AS $$
  	BEGIN
   	 	RETURN (SELECT ("Disc_ID", "Nat") FROM "Rel_Dis_Mod" WHERE "ID_Modulo" = dMOD);
  	END;
  	$$;

  CREATE OR REPLACE FUNCTION retrieve_mod_rel_dis_mod (dDisc INT) returns text
  	LANGUAGE plpgsql
  	AS $$
  	BEGIN
   	 	RETURN (SELECT "ID_Modulo" FROM "Rel_Dis_Mod" WHERE "Disc_ID" = dDISC);
  	END;
  	$$;


  CREATE OR REPLACE FUNCTION retrieve_nome_modulo (mID_modulo INT) returns text
  	LANGUAGE plpgsql
  	AS $$
  	BEGIN
  		RETURN (SELECT "Nome" FROM "Modulo" WHERE "ID_Modulo" = mID_modulo);
  	END;
  	$$;

  CREATE OR REPLACE FUNCTION retrieve_trilha_modulo (mID_modulo INT) returns text
  	LANGUAGE plpgsql
  	AS $$
  	BEGIN
  		RETURN (SELECT "ID_Trilha" FROM "Modulo" WHERE "ID_Modulo" = mID_modulo);
  	END;
  	$$;




  CREATE OR REPLACE FUNCTION retrieve_prereq (dDisc INT, dMOD INT) returns text
  	LANGUAGE plpgsql
  	AS $$
  	BEGIN
   	 	RETURN (SELECT "Prereq" FROM "Prereq_Rel_Dis_Mod" WHERE ("Disc_ID" = dDISC AND "ID_Modulo" = dMOD));
  	END;
  	$$;
