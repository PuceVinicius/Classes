CREATE OR REPLACE FUNCTION update_usuario (uLogin varchar(255), uSenha varchar(255), uEmail varchar(255)) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	UPDATE usuario
    SET "Senha" = uSenha, "Email" = uEmail
    WHERE "Login" = uLogin;
	END;
	$$;

CREATE OR REPLACE FUNCTION update_us_pf (uLogin character varying, pPerfil INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	UPDATE us_pf
		SET "PERFIL" = pPerfil
    WHERE "LOGIN" = uLogin;
	END;
	$$;

CREATE OR REPLACE FUNCTION update_servico (sServico INT, sDesc varchar(255)) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	UPDATE servico
		SET "DESC" = sDesc
    WHERE "ID_SERVICO" = sServico;
	END;
	$$;

CREATE OR REPLACE FUNCTION update_permissoes_perfil (pPerfil INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	UPDATE "PERMISSOES_PERFIL"
		SET permissoes = pPermissoes
    WHERE id_perfil = pPerfil;
	END;
	$$;

CREATE OR REPLACE FUNCTION update_freq_cursa (cFreq double precision, cNprof INT, cDisc varchar(255), cPRD daterange, cCPF varchar(11)) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
		UPDATE "Cursa"
 	 	SET "Frequencia" = cFreq
		WHERE "Nprof" = cNprof AND "DISC" = cDisc AND "PRD" = cPRD AND "cpf" = cCPF;
	END;
	$$;

CREATE OR REPLACE FUNCTION update_nota_cursa (cNota double precision, cNprof INT, cDisc varchar(255), cPRD daterange, cCPF varchar(11)) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
		UPDATE "Cursa"
 	 	SET "Nota" = cNota
		WHERE "Nprof" = cNprof AND "DISC" = cDisc AND "PRD" = cPRD AND "cpf" = cCPF;
	END;
	$$;

CREATE OR REPLACE FUNCTION update_status_cursa (cStatus varchar(2), cNprof INT, cDisc varchar(255), cPRD daterange, cCPF varchar(11)) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
		UPDATE "Cursa"
 	 	SET "Status" = cStatus
		WHERE "Nprof" = cNprof AND "DISC" = cDisc AND "PRD" = cPRD AND "cpf" = cCPF;
	END;
	$$;

CREATE OR REPLACE FUNCTION update_modulo (mID_modulo varchar(2), mID_trilha varchar(255), mNome varchar(255)) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
		UPDATE modulo
 	 	SET "Nome" = mNome AND "ID_MODULO" = mID_modulo AND "ID_TRILHA" = mID_triha
    WHERE "ID_MODULO" = mID_modulo;
	END;
	$$;

CREATE OR REPLACE FUNCTION update_trilha (tID_trilha varchar(2), tNome varchar(255)) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	UPDATE "Trilha"
    SET "Nome" = tNome
		WHERE "ID_TRILHA" = tID_trilha;
	END;
	$$;

CREATE OR REPLACE FUNCTION update_planeja (pCPF varchar(11), pDISC varchar(20), pPeriodo date) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	UPDATE "Planeja"
		SET "Periodo" = pPeriodo
		WHERE "cpf" = pCPF AND "ID_DISCIPLINA" = pDISC;
	END;
	$$;

CREATE OR REPLACE FUNCTION update_aluno (aNUSP INT, aCurso varchar(255)) returns void
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
		SET "Espec" = pEspec
		WHERE "NUSP" = pNUSP;
	END;
	$$;

CREATE OR REPLACE FUNCTION update_admin (aCPF varchar(11), aPerfil INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
		UPDATE "Administrador"
		SET "Perfil" = aPerfil
		WHERE "cpf" = aCPF;
	END;
	$$;

CREATE OR REPLACE FUNCTION update_administra (aCurso INT, aPeriodo daterange, aNUSP INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
		UPDATE "Administra"
		SET "Periodo" = aPeriodo
		WHERE "NUSP" = aNUSP AND "Curso" = aCurso;
	END;
	$$;

CREATE OR REPLACE FUNCTION update_nome_pessoa (pCPF text, pNome character varying) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	UPDATE "Pessoa"
		SET "Nome" = pNome
		WHERE "CPF" = pCPF;
	END;
	$$;

CREATE OR REPLACE FUNCTION update_email_pessoa (pCPF text, pEmail character varying) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	UPDATE "Pessoa"
		SET "Email" = pEmail
		WHERE "CPF" = pCPF;
	END;
	$$;

CREATE OR REPLACE FUNCTION update_pessoalogin (pCPF text, pLogin character varying) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	UPDATE "Pessoa_Login"
		SET "Login" = pLogin
		WHERE "CPF" = pCPF;
	END;
	$$;

CREATE OR REPLACE FUNCTION update_sala_do (dDISC varchar(20), dNPROF INT, dPRD daterange, dSala varchar(255)) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	UPDATE "Disciplina_Oferecimento"
		SET "Sala" = dSala
		WHERE id_disciplina = dDISC AND "NPROF" = dNPROF AND "PRD" = dPRD;
	END;
	$$;

CREATE OR REPLACE FUNCTION update_turma_do (dDISC varchar(20), dNPROF INT, dPRD daterange, dTurma varchar(255)) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	UPDATE "Disciplina_Oferecimento"
		SET "Turma" = dTurma
		WHERE id_disciplina = dDISC AND "NPROF" = dNPROF AND "PRD" = dPRD;
	END;
	$$;

CREATE OR REPLACE FUNCTION update_monitor_do (dDISC varchar(20), dNPROF INT, dPRD daterange, dMntr varchar(255)) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	UPDATE "Disciplina_Oferecimento"
		SET "Monitor" = dMntr
		WHERE id_disciplina = dDISC AND "NPROF" = dNPROF AND "PRD" = dPRD;
	END;
	$$;

CREATE OR REPLACE FUNCTION update_instituto_do (dDISC varchar(20), dNPROF INT, dPRD daterange, dInsti varchar(255)) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	UPDATE "Disciplina_Oferecimento"
		SET "Instituto" = dInsti
		WHERE id_disciplina = dDISC AND "NPROF" = dNPROF AND "PRD" = dPRD;
	END;
	$$;

CREATE OR REPLACE FUNCTION update_creditos_di (dDISC varchar(20), CR_A INT, CR_T INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	UPDATE "Disciplina_Info"
		SET "CR_A" = CR_A, "CR_T" = CR_T
		WHERE "DISC" = dDISC;
	END;
	$$;

CREATE OR REPLACE FUNCTION update_nome_di (dDISC varchar(20), dNome CHAR(255)) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	UPDATE "Disciplina_Info"
		SET "Nome" = dNome
		WHERE "DISC" = dDISC;
	END;
	$$;

CREATE OR REPLACE FUNCTION update_desc_di (dDISC varchar(20), dDESC CHAR(255)) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	UPDATE "Disciplina_Info"
		SET "DESC" = dDESC
		WHERE "DISC" = dDISC;
	END;
	$$;

CREATE OR REPLACE FUNCTION update_rel_dis_mod (dDISC varchar(20), dMOD INT, dNAT CHAR(255)) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	UPDATE rel_dis_mod
		SET nat = dNAT
		WHERE "DISC" = dDISC AND id_modulo = dMOD;
	END;
	$$;

CREATE OR REPLACE FUNCTION update_prereq (dDISC varchar(20), dMOD INT, PREREQ varchar) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	UPDATE PREREQ_REL_DIS_MOD
		SET prereq = PREREQ
		WHERE id_discplina = dDISC AND id_modulo = dMOD;
	END;
	$$;
