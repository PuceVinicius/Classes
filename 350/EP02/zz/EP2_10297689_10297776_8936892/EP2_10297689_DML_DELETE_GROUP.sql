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

CREATE OR REPLACE FUNCTION delete_cursa (cid_pessoa INT, cDisc INT, cPRD date) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
		DELETE FROM "Cursa"
 	 	WHERE "Disc_ID" = cDISC AND "Prd" = cPRD AND "ID_Professor" = cid_pessoa;
	END;
	$$;

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

CREATE OR REPLACE FUNCTION delete_planeja (pid_pessoa INT, pDisc INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	DELETE FROM "Planeja"
		WHERE "ID_Pessoa" = pid_pessoa AND "Disc_ID" = pDISC;
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

CREATE OR REPLACE FUNCTION delete_admin (aid_pessoa INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
		DELETE FROM "Administrador"
		WHERE "ID_Pessoa" = aid_pessoa;
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

CREATE OR REPLACE FUNCTION delete_oferecimento (oid_pessoa INT, oDisc INT, oPRD date) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
		DELETE FROM "Oferecimento"
		WHERE "ID_Professor" = oid_pessoa AND "Disc_ID" = oDISC AND "Prd" = oPRD;
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

CREATE OR REPLACE FUNCTION delete_do (dDisc INT, did_pessoa INT, dPRD date) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	DELETE FROM "Disciplina_Oferecimento"
		WHERE "Disc_ID" = dDISC AND "ID_Pessoa" = did_pessoa AND "Prd" = dPRD;
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
