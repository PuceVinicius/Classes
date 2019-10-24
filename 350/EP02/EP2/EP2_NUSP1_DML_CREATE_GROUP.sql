CREATE OR REPLACE FUNCTION insert_usuario (uLogin varchar(255), uSenha varchar(255), uEmail varchar(255)) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	INSERT INTO usuario ("Login", "Senha", "Email")
    	VALUES (uLogin, uSenha, uEmail);
	END;
	$$;

CREATE OR REPLACE FUNCTION insert_us_pf (pPerfil INT, uLogin character varying) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	INSERT INTO us_pf ("PERFIL", "LOGIN")
    	VALUES (pPerfil);
	END;
	$$;

CREATE OR REPLACE FUNCTION insert_pf_se (pPerfil INT, pServico INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	INSERT INTO pf_se ("PERFIL", "SERVICO")
    	VALUES (pPerfil, pServico);
	END;
	$$;

CREATE OR REPLACE FUNCTION insert_servico (sServico INT, sDesc varchar(255)) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	INSERT INTO servico ("ID_SERVICO", "DESC")
    VALUES (sServico, sDesc);
	END;
	$$;

CREATE OR REPLACE FUNCTION insert_perfil (pPerfil INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	INSERT INTO "Perfil" ("PERFIL")
    	VALUES (pPerfil);
	END;
	$$;

CREATE OR REPLACE FUNCTION insert_permissoes_perfil (pPerfil INT, permissoes bool[]) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	INSERT INTO "PERMISSOES_PERFIL" (id_perfil, permissoes)
    VALUES (pPerfil, permissoes);
	END;
	$$;

CREATE OR REPLACE FUNCTION insert_cursa (cStatus varchar(2), cNota double precision, cFreq double precision, cNprof INT, cDisc varchar(255), cPRD daterange, cCPF varchar(11)) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	INSERT INTO "Cursa" ("Status", "Nota", "Frequencia", "Nprof", "DISC", "PRD","cpf")
		VALUES (cStatus, cNota, cFreq, cNprof, cDisc, cPRD, cCPF);
	END;
	$$;

CREATE OR REPLACE FUNCTION insert_modulo (mID_modulo varchar(2), mID_trilha varchar(255), mNome varchar(255)) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	INSERT INTO modulo ("Nome", "ID_MODULO", "ID_TRILHA")
    VALUES (mNome, mID_modulo, mID_trilha);
	END;
	$$;

CREATE OR REPLACE FUNCTION insert_curriculo (cCURSO INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	INSERT INTO curriculo ("CURSO")
    	VALUES (cCURSO);
	END;
	$$;

CREATE OR REPLACE FUNCTION insert_grade_curriculo (cCURSO INT, cDISC varchar(255)) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	INSERT INTO "GRADE_CURRICULO" (id_curso, id_disciplina)
    	VALUES (cCURSO, cDISC);
	END;
	$$;

CREATE OR REPLACE FUNCTION insert_periodo_curriculo (cCURSO INT, cPRD date) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	INSERT INTO periodo_curriculo (id_curso, periodo)
    VALUES (cCURSO, cPRD);
	END;
	$$;

CREATE OR REPLACE FUNCTION insert_trilha (tID_trilha varchar(2), tNome varchar(255)) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	INSERT INTO "Trilha" ("ID_TRILHA", "Nome")
    VALUES (tID_trilha, tNome);
	END;
	$$;

CREATE OR REPLACE FUNCTION insert_planeja (pCPF varchar(11), pDISC varchar(20), pPeriodo date) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	INSERT INTO "Planeja" ("cpf", "ID_DISCIPLINA", "Periodo")
		VALUES (pCPF, pDISC, pPeriodo);
	END;
	$$;

CREATE OR REPLACE FUNCTION insert_aluno (aCPF varchar(11), aCurso INT, aNUSP INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
		INSERT INTO "Aluno" ("NUSP", "Curso", cpf)
		VALUES (aNUSP, aCurso, aCPF);
	END;
	$$;

CREATE OR REPLACE FUNCTION insert_professor (pCPF varchar(11), pEspec varchar(255), pNUSP INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
		INSERT INTO "Professor" ("NUSP", "Espec", "CPF")
		VALUES (pNUSP, pEspec, pCPF);
	END;
	$$;

CREATE OR REPLACE FUNCTION insert_admin (aCPF varchar(11), aPerfil INT, aNUSP INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
		INSERT INTO "Administrador" ("NUSP", "Perfil", "cpf")
		VALUES (pNUSP, aPerfil, aCPF);
	END;
	$$;

CREATE OR REPLACE FUNCTION insert_administra (aCurso INT, aPeriodo daterange, aNUSP INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
		INSERT INTO "Administra" ("NUSP", "Curso", "Periodo")
		VALUES (aNUSP, aCurso, aPeriodo);
	END;
	$$;

CREATE OR REPLACE FUNCTION insert_rel_cur_tri (rCurso INT, rID_trilha varchar(2)) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
		INSERT INTO rel_cur_tri (id_curso, id_trilha)
		VALUES (rCurso, rID_trilha);
	END;
	$$;

CREATE OR REPLACE FUNCTION insert_drel_cur_tri (rCurso INT, rID_trilha INT, rDISC varchar(20)) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
		INSERT INTO drel_cur_tri (id_curso, id_trilha, id_disciplina)
		VALUES (rCurso, rID_trilha);
	END;
	$$;

CREATE OR REPLACE FUNCTION insert_oferecimento (oNPROF INT, oDISC varchar(20), oPRD date) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
		INSERT INTO oferecimento ("NPROF", "DISC", "PRD")
		VALUES (oNPROF, oDISC, oPRD);
	END;
	$$;

CREATE OR REPLACE FUNCTION insert_pessoa (pCPF text, pNome character varying, pEmail character varying) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	INSERT INTO "Pessoa" ("CPF", "Nome", "Email")
    	VALUES (pCPF, pNome, pEmail);
	END;
	$$;

CREATE OR REPLACE FUNCTION insert_pessoalogin (pCPF text, pLogin character varying) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	INSERT INTO "Pessoa_Login" ("CPF", "LOGIN")
    	VALUES (pCPF, pLogin);
	END;
	$$;

CREATE OR REPLACE FUNCTION insert_do (dDISC varchar(20), dNPROF INT, dPRD daterange, dSala varchar(255), dTurma varchar(255), dMntr varchar(255), dInsti varchar(255)) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	INSERT INTO "Disciplina_Oferecimento" (id_disciplina, "NPROF", "PRD", "Sala", "Turma", "Monitor", "Instituto")
    VALUES (dDISC, dNPROF, dPRD, dSala, dTurma, dMntr, dInsti);
	END;
	$$;

CREATE OR REPLACE FUNCTION insert_di (dDISC varchar(20), CR_A INT, CR_T INT, dDESC CHAR(255), dNome CHAR(255)) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	INSERT INTO "Disciplina_Info" ("DISC", "CR_A", "CR_T", "DESC", "NOME")
    VALUES (dDISC, CR_A, CR_T, dDESC, dNome);
	END;
	$$;

CREATE OR REPLACE FUNCTION insert_rel_dis_mod (dDISC varchar(20), dMOD INT, dNAT CHAR(255)) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	INSERT INTO rel_dis_mod ("DISC", id_modulo, nat)
    VALUES (dDISC, dMOD, dNAT);
	END;
	$$;

CREATE OR REPLACE FUNCTION insert_prereq (dDISC varchar(20), dMOD INT, PREREQ varchar) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	INSERT INTO rel_dis_mod (id_discplina, id_modulo, prereq)
    VALUES (dDISC, dMOD, prereq);
	END;
	$$;
