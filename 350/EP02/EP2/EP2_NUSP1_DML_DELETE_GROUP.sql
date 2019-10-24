CREATE OR REPLACE FUNCTION delete_usuario (uLogin varchar(255)) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	DELETE FROM usuario
    WHERE "Login" = uLogin;
	END;
	$$;

CREATE OR REPLACE FUNCTION delete_us_pf (uLogin character varying) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	DELETE FROM us_pf
    WHERE "LOGIN" = uLogin;
	END;
	$$;

CREATE OR REPLACE FUNCTION delete_pf_se (pPerfil INT, pServico INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	DELETE FROM pf_se
    WHERE "PERFIL" = pPerfil AND "SERVICO" = pServico;
	END;
	$$;

CREATE OR REPLACE FUNCTION delete_servico (sServico INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	DELETE FROM servico
    WHERE "ID_SERVICO" = sServico;
	END;
	$$;

CREATE OR REPLACE FUNCTION delete_perfil (pPerfil INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
		DELETE FROM "Perfil"
		WHERE "PERFIL" = pPerfil;
	END;
	$$;

CREATE OR REPLACE FUNCTION delete_permissoes_perfil (pPerfil INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	DELETE FROM "PERMISSOES_PERFIL"
    WHERE id_perfil = pPerfil;
	END;
	$$;

CREATE OR REPLACE FUNCTION delete_cursa (cNprof INT, cDisc varchar(255), cPRD daterange, cCPF varchar(11)) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
		DELETE FROM "Cursa"
 	 	WHERE "Nprof" = cNprof AND "DISC" = cDISC AND "PRD" = cPRD AND "cpf" = cCPF;
	END;
	$$;

CREATE OR REPLACE FUNCTION delete_modulo (mID_modulo varchar(2)) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	DELETE FROM modulo
    WHERE "ID_MODULO" = mID_modulo;
	END;
	$$;

CREATE OR REPLACE FUNCTION delete_curriculo (cCURSO INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	DELETE FROM curriculo
		WHERE "CURSO" = cCurso;
	END;
	$$;

CREATE OR REPLACE FUNCTION delete_grade_curriculo (cCURSO INT, cDISC varchar(255)) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	DELETE FROM "GRADE_CURRICULO"
    WHERE id_curso = cCURSO AND id_disciplina = cDISC;
	END;
	$$;

CREATE OR REPLACE FUNCTION delete_periodo_curriculo (cCURSO INT, cPRD date) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	DELETE FROM periodo_curriculo
    WHERE id_curso = cCURSO AND periodo = cPRD;
	END;
	$$;

CREATE OR REPLACE FUNCTION delete_trilha (tID_trilha varchar(2)) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	DELETE FROM "Trilha"
    WHERE "ID_TRILHA" = tID_trilha;
	END;
	$$;

CREATE OR REPLACE FUNCTION delete_planeja (pCPF varchar(11), pDISC varchar(20), pPeriodo date) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	DELETE FROM "Planeja"
		WHERE "cpf" = pCPF AND "ID_DISCIPLINA" = pDISC;
	END;
	$$;

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

CREATE OR REPLACE FUNCTION delete_admin (aCPF varchar(11)) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
		DELETE FROM "Administrador"
		WHERE "cpf" = aCPF;
	END;
	$$;

CREATE OR REPLACE FUNCTION delete_administra (aCurso INT, aPeriodo daterange, aNUSP INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
		DELETE FROM "Administra"
		WHERE "NUSP" = aNUSP AND "Curso" = aCurso AND "Periodo" = aPeriodo;
	END;
	$$;

CREATE OR REPLACE FUNCTION delete_rel_cur_tri (rCurso INT, rID_trilha varchar(2)) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
		DELETE FROM rel_cur_tri
		WHERE id_curso = rCurso AND id_trilha = rID_trilha;
	END;
	$$;

CREATE OR REPLACE FUNCTION delete_drel_cur_tri (rCurso INT, rID_trilha INT, rDISC varchar(20)) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
		DELETE FROM drel_cur_tri
		WHERE id_curso = rCurso AND id_trilha = rID_trilha AND id_disciplina = rDISC;
	END;
	$$;

CREATE OR REPLACE FUNCTION delete_oferecimento (oNPROF INT, oDISC varchar(20), oPRD date) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
		DELETE FROM oferecimento
		WHERE "NPROF" = oNPROF AND "DISC" = oDISC AND "PRD" = oPRD;
	END;
	$$;

CREATE OR REPLACE FUNCTION delete_pessoa (pCPF text) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	DELETE FROM "Pessoa"
		WHERE "CPF" = pCPF;
	END;
	$$;

CREATE OR REPLACE FUNCTION delete_pessoalogin (pCPF text) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	DELETE FROM "Pessoa_Login"
		WHERE "CPF" = pCPF;
	END;
	$$;

CREATE OR REPLACE FUNCTION delete_do (dDISC varchar(20), dNPROF INT, dPRD daterange) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	DELETE FROM "Disciplina_Oferecimento"
		WHERE id_disciplina = dDISC AND "NPROF" = dNPROF AND "PRD" = dPRD;
	END;
	$$;

CREATE OR REPLACE FUNCTION delete_di (dDISC varchar(20)) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	DELETE FROM "Disciplina_Info"
		WHERE "DISC" = dDISC;
	END;
	$$;

CREATE OR REPLACE FUNCTION delete_rel_dis_mod (dDISC varchar(20), dMOD INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	DELETE FROM rel_dis_mod
		WHERE "DISC" = dDISC AND id_modulo = dMOD;
	END;
	$$;

CREATE OR REPLACE FUNCTION delete_prereq (dDISC varchar(20), dMOD INT, PREREQ varchar) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	DELETE FROM PREREQ_REL_DIS_MOD
		WHERE id_discplina = dDISC AND id_modulo = dMOD AND prereq = PREREQ;
	END;
	$$;
