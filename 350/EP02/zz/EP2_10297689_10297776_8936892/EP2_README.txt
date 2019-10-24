Vinicius Moreno da Silva -- 10297776
Gabriel Miranda de Araujo -- 10297689
Lucas Marques Gasparino -- 8936892

exemplos de CREATE:

SELECT insert_usuario (1, 'ABC1234', 'lenadoanderson@gmail.com');
SELECT insert_servico (1, 'Requer matrícula em disciplina dentro do período de requerimento', 'Requerimento de Disciplina');
SELECT insert_perfil  (1, 'Aluno de Graduação');
SELECT insert_curriculo (45052, 'BCC 2017');
SELECT insert_trilha (1, 'Sistemas de Software');
SELECT insert_di (1, 4, 2, 'Aplica os conhecimentos apreendidos em Introdução à Ciência de Computação', 'MAC0111    Laboratório de Ciências de Computação');
SELECT insert_pessoa (1, 'Leandro Anderson Giovanni da Luz', '65560141097', 1);
SELECT insert_aluno (1, 45052, 8936891);
SELECT insert_professor (11, 'Bioinformática', 5023183);
SELECT insert_admin (16, 1, 5023188);
SELECT insert_administra (45052, '01-01-2017', 16);
SELECT insert_us_pf (1, 1);
SELECT insert_pf_se (1, 1);
SELECT insert_modulo (1, 1, 'Sistemas Persistentes');
SELECT insert_grade_curriculo (45052, 1);
SELECT insert_periodo_curriculo (45052, '05-05-2017');
SELECT insert_planeja (1, 1);
SELECT insert_rel_cur_tri (45052, 1);
SELECT insert_oferecimento (11, 1, '01-02-2019');
SELECT insert_do (1, 11, '01-02-2019', 'B10', 'T45', 'Luiz Gonçalvez', 'IME');
SELECT insert_rel_dis_mod (1, 1, 'O');
SELECT insert_prereq (1, 1, 'MAT0101 - Cálculo 1');

exemplos de DELETE:

SELECT delete_usuario(1);
SELECT delete_us_pf(1);
SELECT delete_pf_se(1,1);
SELECT delete_servico(1);
SELECT delete_perfil(1);
SELECT delete_cursa(1,1,'2019-01-01');
SELECT delete_modulo(1);
SELECT delete_curriculo(1);
SELECT delete_grade_curriculo(1,1);
SELECT delete_periodo_curriculo(1,'2019-01-01');
SELECT delete_trilha(1);
SELECT delete_planeja(1,1);
SELECT delete_aluno(10297689);
SELECT delete_professor(10297689);
SELECT delete_admin(1);
SELECT delete_administra(1,'2019-01-01',1);
SELECT delete_rel_cur_tri(1,1);
SELECT delete_drel_cur_tri(1,1,1);
SELECT delete_oferecimento(1,1,'2019-01-01');
SELECT delete_pessoa(1);
SELECT delete_do(1,1,'2019-01-01');
SELECT delete_di(1);
SELECT delete_rel_dis_mod(1,1);
SELECT delete_prereq(1,1,'MAC0110');

exemplos de UPDATE:

SELECT update_usuario(1,'minhasenha', 'meuemail@usp.br');
SELECT update_us_pf(1,1);
SELECT update_servico(1,'descriçao', 'nome do serviço');
SELECT update_freq_cursa(0.9,1,'2019-01-01',1);
SELECT update_nota_cursa(10.0,1,'2019-01-01',1);
SELECT update_status_cursa('A',1,'2019-01-01',1);
SELECT update_modulo(1,1,'nomemodulo');
SELECT update_trilha(1,'nome');
SELECT update_aluno(1,1);
SELECT update_professor('ml',1);
SELECT update_admin(1,1);
SELECT update_administra(1,'2019-01-01',1);
SELECT update_nome_pessoa(1,'nomedapessoa');
SELECT update_cpf_pessoa(1,'04449091175');
SELECT update_sala_do(1,1,'2019-01-01','b1');
SELECT update_turma_do(1,1,'2019-01-01','45');
SELECT update_monitor_do(1,1,'2019-01-01','joao da silva');
SELECT update_instituto_do(1,1,'2019-01-01','IME');
SELECT update_creditos_di(1,1,1);
SELECT update_nome_di(1,'nome');
SELECT update_desc_di(1,'descricao');
SELECT update_rel_dis_mod(1,1,'O');
SELECT update_prereq(1,1,'MAC115');

exemplos de RETRIVAL:
SELECT retrieve_usuario(1);
SELECT retrieve_perfil(1);
SELECT retrieve_perfil_us_pf(1);
SELECT retrieve_us_id_us_pf(1);
SELECT retrieve_perfil_us_pf(1);
SELECT retrieve_servico_pf_se(1);
SELECT retrieve_perfis_pf_se(1)
SELECT retrieve_servico(1);
SELECT retrieve_status_cursa(1,1,'2019-01-01');
SELECT retrieve_reprovados_cursa(1,1,'2019-01-01');
SELECT retrieve_aprovados_cursa(1,1,'2019-02-02');
SELECT retrieve_inscritos_cursa(1,1,'2019-02-01');
SELECT retrieve_matriculados_cursa(1,1,'2019-01-01');
SELECT retrieve_freqs_cursa(1,1,'2019-01-01');
SELECT retrieve_nome_trilha(1);
SELECT retrieve_allnomes_trilha('joao da silva');
SELECT retrieve_id_pessoa_planeja(1);
SELECT retrieve_aluno(1);
SELECT retrieve_professor(10297689);
SELECT retrieve_admin(1);
SELECT retrieve_cursos_rel_cur_tri(1);
SELECT retrieve_trilhas_rel_cur_tri(1);
SELECT retrieve_ctdisc_drel_cur_tri(1,1);
SELECT retrieve_tdisc_drel_cur_tri(1);
SELECT retrieve_cdisc_drel_cur_tri(1);
SELECT retrieve_discprof_prd_o('2019-01-01');
SELECT retrieve_prof_prd_o('2019-01-01');
SELECT retrieve_disc_prd_o('2019-01-01');
SELECT retrieve_prof_disc_o(1);
SELECT retrieve_prd_disc_o(1);
SELECT retrieve_disc_prof_o(1);
SELECT retrieve_nome_pessoa(1);
SELECT retrieve_usid_pessoa(1);
SELECT retrieve_sala_do(1,1,'2019-01-01');
SELECT retrieve_turma_do(1,1,'2019-01-01');
SELECT retrieve_monitor_do(1,1,'2019-01-01');
SELECT retrieve_instituto_do(1,1,'2019-01-01');
SELECT retrieve_monitores_do(1);
SELECT retrieve_salas_do(1);
SELECT retrieve_creditos_di(1);
SELECT retrieve_nomedesc_di(1);
SELECT retrieve_di(1);
SELECT retrieve_nat_rel_dis_mod('O');
SELECT retrieve_discmod_rel_dis_mod(1);
SELECT retrieve_mod_rel_dis_mod(1);
SELECT retrieve_nome_modulo(1);
SELECT retrieve_trilha_modulo(1);
SELECT retrieve_prereq(1,1);
