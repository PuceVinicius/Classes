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

CREATE OR REPLACE FUNCTION insert_cursa (cStatus varchar(2), cNota double precision, cFreq double precision, cid_prof INT, cDisc INT, cPRD date, cid_aluno INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	INSERT INTO "Cursa" ("Status", "Nota", "Frequencia", "ID_Professor", "Disc_ID", "Prd", "ID_Aluno")
		VALUES (cStatus, cNota, cFreq, cid_prof, cDisc, cPRD, cid_aluno);
	END;
	$$;

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

CREATE OR REPLACE FUNCTION insert_planeja (pid_pessoa INT, pDisc INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	INSERT INTO "Planeja" ("ID_Pessoa", "Disc_ID")
		VALUES (pid_pessoa, pDISC);
	END;
	$$;

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

CREATE OR REPLACE FUNCTION insert_administra (aCurso INT, aPeriodo date, aNUSP INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
		INSERT INTO "Administra" ("ID_Pessoa", "Curso", "Prd")
		VALUES (aNUSP, aCurso, aPeriodo);
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

CREATE OR REPLACE FUNCTION insert_oferecimento (oid_pessoa INT, oDisc INT, oPRD date) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
		INSERT INTO "Oferecimento" ("ID_Professor", "Disc_ID", "Prd")
		VALUES (oid_pessoa, oDISC, oPRD);
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

CREATE OR REPLACE FUNCTION insert_do (dDisc INT, did_pessoa INT, dPRD date, dSala varchar(255), dTurma varchar(255), dMntr varchar(255), dInsti varchar(255)) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	INSERT INTO "Disciplina_Oferecimento" ("Disc_ID", "ID_Pessoa", "Prd", "Sala", "Turma", "Monitor", "Instituto")
    VALUES (dDISC, did_pessoa, dPRD, dSala, dTurma, dMntr, dInsti);
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
