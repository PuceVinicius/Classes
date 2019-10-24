
---------usuario






CREATE OR REPLACE FUNCTION retrieve_usuario (uus_id INT) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	RETURN(SELECT us_email FROM "User");
	END;
	$$;

---------us_pf


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

----------pf_se




CREATE OR REPLACE FUNCTION retrieve_servico_pf_se (pPerfil INT) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	RETURN (SELECT "Servico"
			 			FROM pf_se
						WHERE "Perfil" = pPerfil);
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_perfis_pf_se (pServico INT) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	RETURN (SELECT "Perfil" FROM pf_se WHERE "Servico" = pServico);
	END;
	$$;
----------servico







CREATE OR REPLACE FUNCTION retrieve_servico (sServico INT) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	RETURN (SELECT ("Nome", "Desc") FROM servico WHERE "ID_Servico" = sServico);
	END;
	$$;

-------cursa









CREATE OR REPLACE FUNCTION retrieve_status_cursa (cid_pessoa INT, cDisc INT, cPRD date) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
		RETURN(SELECT ("ID_Aluno", "Status")
					FROM "Cursa"
					WHERE ("ID_Pessoa" = cid_pessoa AND "Disc_ID" = cDisc AND "Prd" = cPRD
		));
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_reprovados_cursa (cid_pessoa INT, cDisc INT, cPRD date) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
		RETURN(SELECT "ID_Aluno"
					FROM "Cursa"
					WHERE ("ID_Professor" = cid_pessoa AND "Disc_ID" = cDisc AND "Prd" = cPRD AND ("Status" = "RA" OR "Status" = "RN" OR "Status" = "RF")
		));
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_aprovados_cursa (cid_pessoa INT, cDisc INT, cPRD date) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
		RETURN(SELECT "ID_Aluno"
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


----modulo





-------curriculo







-----------trilha






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

--------planeja






CREATE OR REPLACE FUNCTION retrieve_id_pessoa_planeja (pDisc INT) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	RETURN (SELECT "ID_Pessoa" FROM "Planeja" WHERE "ID_DISCIPLINA" = pDISC );
	END;
	$$;

-------aluno






CREATE OR REPLACE FUNCTION retrieve_aluno (aid_pessoa INT) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
		RETURN (SELECT ("NUSP", "Curso")
						FROM "Aluno"
						WHERE "ID_Pessoa" = aid_pessoa);
	END;
	$$;
------------professor






CREATE OR REPLACE FUNCTION retrieve_professor (pNUSP INT) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
		RETURN (SELECT "Especializacao" FROM "Professor" WHERE "NUSP" = pNUSP);
	END;
	$$;
------------admin






CREATE OR REPLACE FUNCTION retrieve_admin (aid_pessoa INT) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
		RETURN (SELECT ("NUSP", "Perfil")
			FROM "Administrador"
			WHERE "ID_Pessoa" = aid_pessoa);
	END;
	$$;

-------rel_cur_tri




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

----------disciplinas_rel_cur_tri




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
---------oferecimento




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
--------pessoa

CREATE OR REPLACE FUNCTION retrieve_nome_pessoa (pid_pessoa INT) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	RETURN (SELECT "Nome" FROM "Pessoa" WHERE "ID_PESSOA" = pid_pessoa);
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_usid_pessoa (pid_pessoa INT) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	RETURN (SELECT us_id FROM "Pessoa" WHERE "ID_PESSOA" = pid_pessoa);
	END;
	$$;

--------------disciplina






CREATE OR REPLACE FUNCTION retrieve_sala_do (dDisc INT, did_pessoa INT, dPRD date) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	RETURN (SELECT "Sala" FROM "Disciplina_Oferecimento" WHERE ("Disc_ID" = dDISC AND "ID_Professor" = did_pessoa AND "PRD" = dPRD));
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_turma_do (dDisc INT, did_pessoa INT, dPRD date) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	RETURN (SELECT "Turma" FROM "Disciplina_Oferecimento" WHERE ("Disc_ID" = dDISC AND "NPROF" = dNPROF AND "PRD" = dPRD));
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_monitor_do (dDisc INT, did_pessoa INT, dPRD date) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	RETURN (SELECT "Monitor" FROM "Disciplina_Oferecimento" WHERE ("Disc_ID" = dDISC AND "NPROF" = dNPROF AND "PRD" = dPRD));
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_instituto_do (dDisc INT, did_pessoa INT, dPRD date) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	RETURN (SELECT "Instituto" FROM "Disciplina_Oferecimento" WHERE ("Disc_ID" = dDISC AND "NPROF" = dNPROF AND "PRD" = dPRD));
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







CREATE OR REPLACE FUNCTION retrieve_creditos_di (dDisc INT) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	RETURN (SELECT ("CR_A" AND "CR_T") FROM "Disciplina_Info" WHERE "DISC" = dDISC);
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_nomedesc_di (dDisc INT) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	RETURN (SELECT ("Nome" AND "DESC") FROM "Disciplina_Info" WHERE "DISC" = dDISC);
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_di (dDisc INT) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	RETURN (SELECT * FROM "Disciplina_Info" WHERE "DISC" = dDISC);
	END;
	$$;






CREATE OR REPLACE FUNCTION retrieve_nat_rel_dis_mod (dNAT varchar(255)) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	RETURN (SELECT "DISC" FROM "Rel_Dis_Mod" WHERE "Nat" = dNAT);
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_discmod_rel_dis_mod (dMOD INT) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	RETURN (SELECT ("DISC", "Nat") FROM "Rel_Dis_Mod" WHERE "ID_Modulo" = dMOD);
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
