
---------usuario






CREATE OR REPLACE FUNCTION retrieve_usuario (uLogin varchar(255)) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	RETURN(SELECT "Email" FROM usuario);
	END;
	$$;

---------us_pf





CREATE OR REPLACE FUNCTION retrieve_perfil_us_pf (uLogin character varying) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	RETURN (SELECT "PERFIL" FROM us_pf WHERE "LOGIN" = uLogin);
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_login_us_pf (pPerfil INT) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	RETURN (SELECT "LOGIN" FROM us_pf WHERE "PERFIL" = pPerfil);
	END;
	$$;

----------pf_se




CREATE OR REPLACE FUNCTION retrieve_servico_pf_se (pPerfil INT) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	RETURN (SELECT "SERVICO"
			 			FROM pf_se
						WHERE "PERFIL" = pPerfil);
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_perfis_pf_se (pServico INT) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	RETURN (SELECT "PERFIL" FROM pf_se WHERE "SERVICO" = pServico);
	END;
	$$;
----------servico







CREATE OR REPLACE FUNCTION retrieve_servico (sServico INT) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	RETURN (SELECT "DESC" FROM servico WHERE "ID_SERVICO" = sServico);
	END;
	$$;
----------perfil













	CREATE OR REPLACE FUNCTION retrieve_permissoes_perfil (pPerfil INT, pPermissoes bool[]) returns text
		LANGUAGE plpgsql
		AS $$
		BEGIN
	 	 	RETURN (SELECT permissoes FROM "PERMISSOES_PERFIL" WHERE id_perfil = pPerfil);
		END;
		$$;
-------cursa









CREATE OR REPLACE FUNCTION retrieve_status_cursa (cNprof INT, cDisc varchar(255), cPRD daterange) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
		RETURN(SELECT ("cpf", "Status")
					FROM "Cursa"
					WHERE ("Nprof" = cNprof AND "DISC" = cDisc AND "PRD" = cPRD
		));
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_reprovados_cursa (cNprof INT, cDisc varchar(255), cPRD daterange) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
		RETURN(SELECT "cpf"
					FROM "Cursa"
					WHERE ("Nprof" = cNprof AND "DISC" = cDisc AND "PRD" = cPRD AND ("Status" = "RA" OR "Status" = "RN" OR "Status" = "RF")
		));
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_aprovados_cursa (cNprof INT, cDisc varchar(255), cPRD daterange) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
		RETURN(SELECT "cpf"
					FROM "Cursa"
					WHERE ("Nprof" = cNprof AND "DISC" = cDisc AND "PRD" = cPRD AND "Status" = 'A'
		));
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_inscritos_cursa (cNprof INT, cDisc varchar(255), cPRD daterange) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
		RETURN(SELECT "cpf"
					FROM "Cursa"
					WHERE ("Nprof" = cNprof AND "DISC" = cDisc AND "PRD" = cPRD AND "Status" = 'I'
		));
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_matriculados_cursa (cNprof INT, cDisc varchar(255), cPRD daterange) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
		RETURN(SELECT "cpf"
					FROM "Cursa"
					WHERE ("Nprof" = cNprof AND "DISC" = cDisc AND "PRD" = cPRD AND "Status" = 'MA'
		));
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_freqs_cursa (cNprof INT, cDisc varchar(255), cPRD daterange) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
		RETURN(SELECT ("Frequencia", "cpf")
					FROM "Cursa"
					WHERE ("Nprof" = cNprof AND "DISC" = cDisc AND "PRD" = cPRD
		));
	END;
	$$;


----modulo





-------curriculo







-----------trilha






CREATE OR REPLACE FUNCTION retrieve_nome_trilha (tID_trilha varchar(2)) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	RETURN(SELECT "Nome" FROM "Trilha" WHERE "ID_TRILHA" = tID_trilha);
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_allnomes_trilha (tNome varchar(255)) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	RETURN(SELECT "ID_TRILHA" FROM "Trilha" WHERE "Nome" = tNome);
	END;
	$$;

--------planeja






CREATE OR REPLACE FUNCTION retrieve_cpf_planeja (pDISC varchar(20), pPeriodo date) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	RETURN (SELECT "cpf" FROM "Planeja" WHERE ("ID_DISCIPLINA" = pDISC AND "Periodo" = pPeriodo) );
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_periodos_planeja (pDISC varchar(20)) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	RETURN (SELECT "Periodo" FROM "Planeja" WHERE ("ID_DISCIPLINA" = pDISC AND "Periodo" = pPeriodo));
	END;
	$$;

-------aluno






CREATE OR REPLACE FUNCTION retrieve_aluno (aCPF varchar(11)) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
		RETURN (SELECT ("NUSP", "Curso")
						FROM "Aluno"
						WHERE cpf = aCPF);
	END;
	$$;
------------professor






CREATE OR REPLACE FUNCTION retrieve_professor (pNUSP INT) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
		RETURN (SELECT "Espec" FROM "Professor" WHERE "NUSP" = pNUSP);
	END;
	$$;
------------admin






CREATE OR REPLACE FUNCTION retrieve_admin (aCPF varchar(11)) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
		RETURN (SELECT ("NUSP", "PERFIL")
			FROM "Administrador"
			WHERE "cpf" = aCPF);
	END;
	$$;
----------administra





CREATE OR REPLACE FUNCTION retrieve_cursos_administra (aNUSP INT) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
		RETURN(SELECT "Curso" FROM "Administra" WHERE	"NUSP" = aNUSP);
	END;
	$$;

-------rel_cur_tri




CREATE OR REPLACE FUNCTION retrieve_cursos_rel_cur_tri (rID_trilha varchar(2)) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
		RETURN (SELECT id_curso FROM rel_cur_tri WHERE id_trilha = rID_trilha);
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_trilhas_rel_cur_tri (rCurso INT) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
		RETURN (SELECT id_trilha FROM rel_cur_tri WHERE id_curso = rCurso);
	END;
	$$;

----------disciplinas_rel_cur_tri




CREATE OR REPLACE FUNCTION retrieve_ctdisc_drel_cur_tri (rCurso INT, rID_trilha INT) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
		RETURN (SELECT id_disciplina FROM drel_cur_tri WHERE (id_curso = rCurso AND id_trilha = rID_trilha));
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_tdisc_drel_cur_tri (rID_trilha INT) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
		RETURN (SELECT id_disciplina FROM drel_cur_tri WHERE id_trilha = rID_trilha);
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_cdisc_drel_cur_tri (rCurso INT) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
		RETURN (SELECT id_disciplina FROM drel_cur_tri WHERE id_curso = rCurso);
	END;
	$$;
---------oferecimento




CREATE OR REPLACE FUNCTION retrieve_discnprof_prd_o (oPRD date) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
		RETURN (SELECT ("DISC", "NPROF") FROM oferecimento WHERE "PRD" = oPRD);
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_nprof_prd_o (oPRD date) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
		RETURN (SELECT "NPROF" FROM oferecimento WHERE "PRD" = oPRD);
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_disc_prd_o (oPRD date) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
		RETURN (SELECT "DISC" FROM oferecimento WHERE "PRD" = oPRD);
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_nprof_disc_o (oDISC varchar(20)) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
		RETURN (SELECT "NPROF" FROM oferecimento WHERE "DISC" = oDISC);
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_prd_disc_o (oDISC varchar(20)) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
		RETURN (SELECT "PRD" FROM oferecimento WHERE "DISC" = oDISC);
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_disc_nprof_o (oNPROF INT) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
		RETURN (SELECT "DISC" FROM oferecimento WHERE "NPROF" = oNPROF);
	END;
	$$;
--------pessoa







CREATE OR REPLACE FUNCTION retrieve_nome_pessoa (pCPF text) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	RETURN (SELECT "Nome" FROM "Pessoa" WHERE "CPF" = pCPF);
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_email_pessoa (pCPF text) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	RETURN (SELECT "Email" FROM "Pessoa" WHERE "CPF" = pCPF);
	END;
	$$;

-------------pessoa_login






CREATE OR REPLACE FUNCTION retrieve_pessoalogin (pCPF text) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	RETURN (SELECT "LOGIN" FROM "Pessoa_Login" WHERE "CPF" = pCPF);
	END;
	$$;
--------------disciplina






CREATE OR REPLACE FUNCTION retrieve_sala_do (dDISC varchar(20), dNPROF INT, dPRD daterange) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	RETURN (SELECT "Sala" FROM "Disciplina_Oferecimento" WHERE (id_disciplina = dDISC AND "NPROF" = dNPROF AND "PRD" = dPRD));
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_turma_do (dDISC varchar(20), dNPROF INT, dPRD daterange) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	RETURN (SELECT "Turma" FROM "Disciplina_Oferecimento" WHERE (id_disciplina = dDISC AND "NPROF" = dNPROF AND "PRD" = dPRD));
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_monitor_do (dDISC varchar(20), dNPROF INT, dPRD daterange) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	RETURN (SELECT "Monitor" FROM "Disciplina_Oferecimento" WHERE (id_disciplina = dDISC AND "NPROF" = dNPROF AND "PRD" = dPRD));
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_instituto_do (dDISC varchar(20), dNPROF INT, dPRD daterange) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	RETURN (SELECT "Instituto" FROM "Disciplina_Oferecimento" WHERE (id_disciplina = dDISC AND "NPROF" = dNPROF AND "PRD" = dPRD));
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_monitores_do (dDISC varchar(20)) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	RETURN (SELECT "Monitor" FROM "Disciplina_Oferecimento" WHERE id_disciplina = dDISC);
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_salas_do (dDISC varchar(20)) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	RETURN (SELECT "Sala" FROM "Disciplina_Oferecimento" WHERE id_disciplina = dDISC);
	END;
	$$;







CREATE OR REPLACE FUNCTION retrieve_creditos_di (dDISC varchar(20)) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	RETURN (SELECT ("CR_A" AND "CR_T") FROM "Disciplina_Info" WHERE "DISC" = dDISC);
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_nomedesc_di (dDISC varchar(20)) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	RETURN (SELECT ("Nome" AND "DESC") FROM "Disciplina_Info" WHERE "DISC" = dDISC);
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_di (dDISC varchar(20)) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	RETURN (SELECT * FROM "Disciplina_Info" WHERE "DISC" = dDISC);
	END;
	$$;






CREATE OR REPLACE FUNCTION retrieve_nat_rel_dis_mod (dNAT CHAR(255)) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	RETURN (SELECT "DISC" FROM rel_dis_mod WHERE nat = dNAT);
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_discmod_rel_dis_mod (dMOD INT) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	RETURN (SELECT ("DISC", nat) FROM rel_dis_mod WHERE id_modulo = dMOD);
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_mod_rel_dis_mod (dDISC varchar(20)) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	RETURN (SELECT id_modulo FROM rel_dis_mod WHERE id_disciplina = dDISC);
	END;
	$$;


CREATE OR REPLACE FUNCTION retrieve_nome_modulo (mID_modulo CHAR(2)) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
		RETURN (SELECT "Nome" FROM modulo WHERE "ID_MODULO" = mID_modulo);
	END;
	$$;

CREATE OR REPLACE FUNCTION retrieve_trilha_modulo (mID_modulo CHAR(2)) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
		RETURN (SELECT "ID_TRILHA" FROM modulo WHERE "ID_MODULO" = mID_modulo);
	END;
	$$;




CREATE OR REPLACE FUNCTION retrieve_prereq (dDISC varchar(20), dMOD INT) returns text
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	RETURN (SELECT prereq FROM PREREQ_REL_DIS_MOD WHERE (id_discplina = dDISC AND id_modulo = dMOD));
	END;
	$$;
