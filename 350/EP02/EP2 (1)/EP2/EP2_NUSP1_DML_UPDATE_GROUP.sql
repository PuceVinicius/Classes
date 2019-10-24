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

CREATE OR REPLACE FUNCTION update_freq_cursa (cFreq double precision, cid_pessoa INT, cDisc INT, cPRD date, cid_pessoa INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
		UPDATE "Cursa"
 	 	SET "Frequencia" = cFreq
		WHERE "Disc_ID" = cDisc AND "Prd" = cPRD AND "ID_Pessoa" = cid_pessoa;
	END;
	$$;

CREATE OR REPLACE FUNCTION update_nota_cursa (cNota double precision, cid_pessoa INT, cDisc INT, cPRD date, cid_pessoa INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
		UPDATE "Cursa"
 	 	SET "Nota" = cNota
		WHERE "Disc_ID" = cDisc AND "Prd" = cPRD AND "ID_Pessoa" = cid_pessoa;
	END;
	$$;

CREATE OR REPLACE FUNCTION update_status_cursa (cStatus varchar(2), cid_pessoa INT, cDisc INT, cPRD date, cid_pessoa INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
		UPDATE "Cursa"
 	 	SET "Status" = cStatus
		WHERE "Disc_ID" = cDisc AND "Prd" = cPRD AND "ID_Pessoa" = cid_pessoa;
	END;
	$$;

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
		SET "Especializacao" = pEspec
		WHERE "NUSP" = pNUSP;
	END;
	$$;

CREATE OR REPLACE FUNCTION update_admin (aid_pessoa INT, aPerfil INT) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
		UPDATE "Administrador"
		SET "Perfil" = aPerfil
		WHERE "ID_Pessoa" = aid_pessoa;
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

CREATE OR REPLACE FUNCTION update_nome_pessoa (pid_pessoa INT, pNome varchar(255)) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	UPDATE "Pessoa"
		SET "Nome" = pNome
		WHERE "ID_Pessoa" = pid_pessoa;
	END;
	$$;

CREATE OR REPLACE FUNCTION update_cpf_pessoa (pid_pessoa INT, pCPF text) returns void
	LANGUAGE plpgsql
	AS $$
	BEGIN
 	 	UPDATE "Pessoa"
		SET "CPF" = pCPF
		WHERE "ID_Pessoa" = pid_pessoa;
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
