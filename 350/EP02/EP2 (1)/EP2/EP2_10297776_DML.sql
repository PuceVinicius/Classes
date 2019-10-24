SELECT insert_usuario (1, 'ABC1234', 'lenadoanderson@gmail.com');
SELECT insert_usuario (2, 'ABC12345', 'guilhermecalebe@gmail.com');
SELECT insert_usuario (3, 'ABC123456', 'raimundooliver@gmail.com');
SELECT insert_usuario (4, 'ABC1234567', 'thiagobento@hotmail.com');
SELECT insert_usuario (5, 'ABC12345678', 'theo@usp.br');
SELECT insert_usuario (6, 'ABC123456789', 'rafa.mariane@usp.br');
SELECT insert_usuario (7, 'ABC1234567890', 'cardoso@gmail.com');
SELECT insert_usuario (8, 'ABC12345678901', 'nicolas_castro@gmail.com');
SELECT insert_usuario (9, 'ABC123456789012', 'heitor@outlook.com');
SELECT insert_usuario (10, 'ABC123456789012', 'deborally@ime.usp.br');

SELECT insert_usuario (11, 'ABC1234567890123', 'kamily_stella@gmail.com');
SELECT insert_usuario (12, 'ABC12345678901234', 'priscila_nair@hotmail.com');
SELECT insert_usuario (13, 'ABC123456789012345', 'agatha@usp.br');
SELECT insert_usuario (14, 'ABC1234567890123456', 'rodrigoruan@outlook.com');
SELECT insert_usuario (15, 'ABC12345678901234567', 'stella.bianca@gmail.com');
SELECT insert_usuario (16, 'ABC123456789012345678', 'marli.maya@gmail.com');
SELECT insert_usuario (17, 'ABC1234567890123456789', 'allana.carla.alana@ime.usp.br');
SELECT insert_usuario (18, 'ABC12345678901234567890', 'allana.raysa@ime.usp.br');
SELECT insert_usuario (19, 'ABC123456789012345678901', 'sophie.mariah@gmail.com');
SELECT insert_usuario (20, 'ABC1234567890123456789012', 'giihh@outlook.com');
SELECT insert_usuario (21, 'ABC12345678901234567890123', 'antonella@gmail.com');
SELECT insert_usuario (22, 'ABC123456789012345678901234', 'sabrina.moraes@outlook.com');
SELECT insert_usuario (23, 'ABC1234567890123456789012345', 'gustado_henrique@usp.br');
SELECT insert_usuario (24, 'ABC12345678901234567890123456', 'raimunda.sophia@gmail.com');
SELECT insert_usuario (25, 'ABC123456789012345678901234567', 'cristiane.tereza.melo@gmail.com');

SELECT insert_servico (1, 'Requer matrícula em disciplina dentro do período de requerimento', 'Requerimento de Disciplina');
SELECT insert_servico (2, 'Aceitar matrícula de aluno em disciplina requerida', 'Deferimento de Disciplina');
SELECT insert_servico (3, 'Registrar nota de aluno em Disciplina', 'Submeter nota');
SELECT insert_servico (4, 'Registrar frequência de aluno em Disciplina', 'Submeter frequência');
SELECT insert_servico (5, 'Remover disciplina da grade montada pelo aluno na interação de matrícula', 'Remover disciplina da Grade');
SELECT insert_servico (6, 'Adicionar disciplina na grade montada pelo aluno na interação de matrícula', 'Adicionar disciplina na Grade');
SELECT insert_servico (7, 'Visualizar seu histórico escolar de qualquer época em qualquer curso', 'Visualizar histórico escolar');
SELECT insert_servico (8, 'Assinar contrato de estágio de estudante da graduação', 'Aprovar contrato de estágio');
SELECT insert_servico (9, 'Alterar ementa de disciplina administrada pela pessoa', 'Alterar ementa da disciplina');
SELECT insert_servico (10, 'Acesso ao sistema Júpiter', 'Jupiterweb');
SELECT insert_perfil  (1, 'Aluno de Graduação');
SELECT insert_perfil  (2, 'Professor Associado');
SELECT insert_perfil  (3, 'Professor Titular');
SELECT insert_perfil  (4, 'Professor Honorário');
SELECT insert_perfil  (5, 'Aluno de Pós-Graduação');
SELECT insert_perfil  (6, 'Aluno especial');
SELECT insert_perfil  (7, 'Funcionário');
SELECT insert_perfil  (8, 'Professor Doutor');
SELECT insert_perfil  (9, 'Reitor');
SELECT insert_perfil  (10, 'Visitante');
SELECT insert_curriculo (45052, 'BCC 2017');
SELECT insert_curriculo (45051, 'BCC 2016');
SELECT insert_curriculo (45042, 'BCC 2015');
SELECT insert_curriculo (45041, 'BCC 2014');
SELECT insert_curriculo (45032, 'BCC 2013');
SELECT insert_curriculo (45031, 'BCC 2012');
SELECT insert_curriculo (45022, 'BCC 2011');
SELECT insert_curriculo (45021, 'BCC 2008');
SELECT insert_curriculo (45012, 'BCC 2006');
SELECT insert_curriculo (45011, 'BCC 2001');
SELECT insert_trilha (1, 'Sistemas de Software');
SELECT insert_trilha (2, 'Inteligência Artificial');
SELECT insert_trilha (3, 'E-Science');
SELECT insert_trilha (4, 'Teoria da Computação');
SELECT insert_trilha (5, 'Bioinformática');
SELECT insert_trilha (6, 'Design');
SELECT insert_trilha (7, 'Robótica');
SELECT insert_trilha (8, 'Eletrônica');
SELECT insert_trilha (9, 'Algoritmos Avançados');
SELECT insert_trilha (10, 'Jogos');
SELECT insert_di (1, 4, 2, 'Aplica os conhecimentos apreendidos em Introdução à Ciência de Computação', 'MAC0111    Laboratório de Ciências de Computação');
SELECT insert_di (2, 2, 0, ' Apresentar o Bacharelado em Ciência da Computação (BCC) aos estudantes que acabaram de ingressar no curso.', 'MAC0101 	Integração na Universidade e na Profissão');
SELECT insert_di (3, 2, 2, 'Familiarizar o aluno com a linguagem matemática e com a estrutura das demonstrações matemáticas, bem como com alguns fatos e noções elementares sobre números, conjuntos, funções e relações.', 'MAC0105 	Fundamentos de Matemática para a Computação ');
SELECT insert_di (4, 4, 0, ' Introduzir a programação de computadores através do estudo de uma linguagem algorítmica e de exercícios práticos. ', 'MAC0110 	Introdução à Computação');
SELECT insert_di (5, 4, 0, 'Estudo de álgebras Booleanas finitas, assim como, as suas aplicações no projeto de circuitos digitais e, em particular, de arquiteturas de computadores. ', 'MAC0329 	Álgebra Booleana e Aplicações no Projeto de Arquitetura de Computadores');
SELECT insert_di (6, 6, 0, 'Familiarizar o aluno com as noções de limite, derivada e integral de funções de uma variável, destacando aspectos geométricos e interpretações físicas.', 'MAT2453 	Cálculo Diferencial e Integral I ');
SELECT insert_di (7, 4, 2, ' Ensinar aos alunos as leis básicas do cálculo vetorial clássico e a geometria analítica em dimensão 2 e 3.', 'MAT0112 	Vetores e Geometria ');
SELECT insert_di (8, 4, 2, 'Introduzir técnicas básicas de programação, estruturas de dados básicas, e noções de projeto e análise de algoritmos, por meio de exemplos. ', 'MAC0121    Algoritmos e Estruturas de Dados I ');
SELECT insert_di (9, 4, 0, 'Expor o estudante a conceitos e ambientes de programação e integração de módulos e programas', 'MAC0216 	Técnicas de Programação I ');
SELECT insert_di (10, 4, 0, 'Dar ao aluno o primeiro contato com métodos formais. Introduzir conceitos básicos para a verificação formal, assim como técnicas de demonstração de corretude de programas. ', 'MAC0239 	Introdução à Lógica e Verificação de Programas ');
SELECT insert_pessoa (1, 'Leandro Anderson Giovanni da Luz', '65560141097', 1);
SELECT insert_pessoa (2, 'Guilherme Calebe Gabriel Araújo', '09536871475', 2);
SELECT insert_pessoa (3, 'Raimundo Oliver Paulo Martins', '49170939888', 3);
SELECT insert_pessoa (4, 'Thiago Bento da Mota', '06187370570', 4);
SELECT insert_pessoa (5, 'Anderson Theo Nunes', '63810317608', 5);
SELECT insert_pessoa (6, 'Rafaela Mariane Sales', '77908064752', 6);
SELECT insert_pessoa (7, 'Manuel Marcos Vinicius Cardoso', '36263533544', 7);
SELECT insert_pessoa (8, 'Guilherme Nicolas Castro', '41080152660', 8);
SELECT insert_pessoa (9, 'Gustavo Heitor Nelson Almeida', '18571467781', 9);
SELECT insert_pessoa (10, 'Débora Isabelly Bruna Dias', '42195556684', 10);
SELECT insert_pessoa (11, 'Kamilly Stella da Silva', '86324985091', 10);
SELECT insert_pessoa (12, 'Priscila Nair Carvalho', '00455872058', 10);
SELECT insert_pessoa (13, 'Agatha Sophie Fogaça', '63358997014', 10);
SELECT insert_pessoa (14, 'Rodrigo Ruan Vicente Fogaça', '01255157070', 10);
SELECT insert_pessoa (15, 'Stella Bianca da Conceição', '74514648060', 10);
SELECT insert_pessoa (16, 'Marli Simone Maya Cavalcanti', '03316804080', 10);
SELECT insert_pessoa (17, 'Allana Carla Alana da Conceição', '88775884038', 10);
SELECT insert_pessoa (18, 'Allana Rayssa Baptista', '88668514008', 10);
SELECT insert_pessoa (19, 'Sophie Mariah Isis da Mota', '51774646013', 10);
SELECT insert_pessoa (20, 'Giovanna Lavínia Caldeira', '17775009071', 10);
SELECT insert_pessoa (21, 'Luana Antonella Agatha Gomes', '03961948003', 10);
SELECT insert_pessoa (22, 'Rosângela Maria Sabrina Moraes', '23570308014', 10);
SELECT insert_pessoa (23, 'Gustavo Henrique Moraes', '29483107091', 10);
SELECT insert_pessoa (24, 'Fabiana Raimunda Sophia da Silva', '31581279035', 10);
SELECT insert_pessoa (25, 'Cristiane Tereza Melo', '36678426002', 10);




SELECT insert_aluno (1, 45052, 8936891);
SELECT insert_aluno (2, 45052, 8936881);
SELECT insert_aluno (3, 45052, 8936871);
SELECT insert_aluno (4, 45051, 8936861);
SELECT insert_aluno (5, 45051, 8936851);
SELECT insert_aluno (6, 45032, 8936841);
SELECT insert_aluno (7, 45032, 8936831);
SELECT insert_aluno (8, 45032, 8936821);
SELECT insert_aluno (9, 45012, 8936811);
SELECT insert_aluno (10,45022, 8936801);



SELECT insert_professor (11, 'Bioinformática', 5023183);
SELECT insert_professor (12, 'Eletrônica', 5023184);
SELECT insert_professor (13, 'Sistemas', 5023185);
SELECT insert_professor (14, 'Bioinformática', 5023186);
SELECT insert_professor (15, 'Bioinformática', 5023187);
SELECT insert_professor (16, 'Data Science', 5023188);
SELECT insert_professor (17, 'Modelagem', 5023189);
SELECT insert_professor (18, 'IA', 5023180);
SELECT insert_professor (19, 'ML', 5023182);
SELECT insert_professor (20, 'Elétrica', 5023181);




SELECT insert_admin (16, 1, 5023188);
SELECT insert_admin (17, 1, 5023189);
SELECT insert_admin (18, 1, 5023180);
SELECT insert_admin (19, 1, 5023182);
SELECT insert_admin (20, 1, 5023181);
SELECT insert_admin (21, 1, 924342);
SELECT insert_admin (22, 1, 824212);
SELECT insert_admin (23, 1, 724212);
SELECT insert_admin (24, 1, 624212);
SELECT insert_admin (25, 1, 524212);


SELECT insert_administra (45052, '01-01-2017', 16);
SELECT insert_administra (45051, '01-01-2016', 17);
SELECT insert_administra (45042, '01-01-2015', 18);
SELECT insert_administra (45041, '01-01-2014', 19);
SELECT insert_administra (45032, '01-01-2013', 20);
SELECT insert_administra (45031, '01-01-2012', 21);
SELECT insert_administra (45022, '01-01-2011', 22);
SELECT insert_administra (45021, '01-01-2010', 23);
SELECT insert_administra (45012, '01-01-2018', 24);
SELECT insert_administra (45011, '01-01-2001', 25);

SELECT insert_us_pf (1, 1);
SELECT insert_us_pf (2, 1);
SELECT insert_us_pf (3, 1);
SELECT insert_us_pf (4, 1);
SELECT insert_us_pf (5, 1);
SELECT insert_us_pf (6, 1);
SELECT insert_us_pf (7, 1);
SELECT insert_us_pf (8, 1);
SELECT insert_us_pf (9, 1);
SELECT insert_us_pf (10, 1);
SELECT insert_us_pf (11, 2);
SELECT insert_us_pf (12, 3);
SELECT insert_us_pf (13, 4);
SELECT insert_us_pf (14, 8);
SELECT insert_us_pf (15, 2);
SELECT insert_us_pf (16, 3);
SELECT insert_us_pf (17, 4);
SELECT insert_us_pf (18, 8);
SELECT insert_us_pf (19, 2);
SELECT insert_us_pf (20, 3);
SELECT insert_us_pf (21, 4);
SELECT insert_us_pf (22, 8);
SELECT insert_us_pf (23, 2);
SELECT insert_us_pf (24, 3);
SELECT insert_us_pf (25, 4);


SELECT insert_pf_se (1, 1);
SELECT insert_pf_se (1, 5);
SELECT insert_pf_se (1, 6);
SELECT insert_pf_se (1, 7);
SELECT insert_pf_se (1, 10);
SELECT insert_pf_se (2, 2);
SELECT insert_pf_se (3, 3);
SELECT insert_pf_se (4, 4);
SELECT insert_pf_se (8, 8);
SELECT insert_pf_se (2, 9);

SELECT insert_modulo (1, 1, 'Sistemas Persistentes');
SELECT insert_modulo (2, 2, 'Maratona de Programação');
SELECT insert_modulo (3, 3, 'Processamento de Imagens');
SELECT insert_modulo (4, 1, 'Eletrônica digital');
SELECT insert_modulo (5, 4, 'Ciência de Dados');
SELECT insert_modulo (6, 3, 'Estrutura de Dados');
SELECT insert_modulo (7, 5, 'Metodologias Ágeis');
SELECT insert_modulo (8, 6, 'Banco de Dados');
SELECT insert_modulo (9, 7, 'Testes');
SELECT insert_modulo (10, 8, 'Desenvolvimento');



SELECT insert_grade_curriculo (45052, 1);
SELECT insert_grade_curriculo (45051, 1);
SELECT insert_grade_curriculo (45051, 2);
SELECT insert_grade_curriculo (45051, 3);
SELECT insert_grade_curriculo (45032, 5);
SELECT insert_grade_curriculo (45032, 6);
SELECT insert_grade_curriculo (45022, 2);
SELECT insert_grade_curriculo (45022, 6);
SELECT insert_grade_curriculo (45012, 8);
SELECT insert_grade_curriculo (45012, 1);



SELECT insert_periodo_curriculo (45052, '05-05-2017');
SELECT insert_periodo_curriculo (45051, '05-05-2016');
SELECT insert_periodo_curriculo (45042, '05-05-2015');
SELECT insert_periodo_curriculo (45041, '05-05-2014');
SELECT insert_periodo_curriculo (45032, '05-05-2013');
SELECT insert_periodo_curriculo (45031, '05-05-2012');
SELECT insert_periodo_curriculo (45022, '05-05-2011');
SELECT insert_periodo_curriculo (45021, '05-05-2010');
SELECT insert_periodo_curriculo (45012, '05-05-2008');
SELECT insert_periodo_curriculo (45011, '05-05-2001');



SELECT insert_planeja (1, 1);
SELECT insert_planeja (1, 2);
SELECT insert_planeja (1, 3);
SELECT insert_planeja (2, 1);
SELECT insert_planeja (2, 4);
SELECT insert_planeja (3, 9);
SELECT insert_planeja (4, 1);
SELECT insert_planeja (4, 9);
SELECT insert_planeja (4, 4);
SELECT insert_planeja (4, 6);


SELECT insert_rel_cur_tri (45052, 1);
SELECT insert_rel_cur_tri (45052, 2);
SELECT insert_rel_cur_tri (45052, 3);
SELECT insert_rel_cur_tri (45052, 4);
SELECT insert_rel_cur_tri (45052, 5);
SELECT insert_rel_cur_tri (45051, 1);
SELECT insert_rel_cur_tri (45042, 1);
SELECT insert_rel_cur_tri (45042, 7);
SELECT insert_rel_cur_tri (45012, 1);
SELECT insert_rel_cur_tri (45011, 8);



SELECT insert_oferecimento (11, 1, '01-02-2019');
SELECT insert_oferecimento (12, 2, '01-02-2018');
SELECT insert_oferecimento (13, 3, '01-02-2017');
SELECT insert_oferecimento (14, 3, '01-02-2016');
SELECT insert_oferecimento (15, 4, '01-02-2015');
SELECT insert_oferecimento (16, 5, '01-02-2014');
SELECT insert_oferecimento (16, 6, '01-02-2013');
SELECT insert_oferecimento (17, 7, '01-02-2012');
SELECT insert_oferecimento (18, 8, '01-02-2011');
SELECT insert_oferecimento (19, 1, '01-02-2010');




Select insert_do (1, 11, '01-02-2019', 'B10', 'T45', 'Luiz Gonçalvez', 'IME');
Select insert_do (2, 12, '01-02-2018', 'B11', 'T44', 'Luiz Gonçalvez', 'IME');
Select insert_do (3, 13, '01-02-2017', 'B12', 'T45', 'João Gonçalvez', 'IME');
Select insert_do (3, 14, '01-02-2016', 'B13', 'T44', 'Maria Gonçalvez', 'IME');
Select insert_do (4, 15, '01-02-2015', 'B14', 'T45', 'Tênia Gonçalvez', 'IME');
Select insert_do (5, 16, '01-02-2014', 'B15', 'T43', 'Tabela Gonçalvez', 'IME');
Select insert_do (6, 16, '01-02-2013', 'B16', 'T45', 'Latina Gonçalvez', 'IME');
Select insert_do (7, 17, '01-02-2012', 'B17', 'T45', 'Maria Gonçalvez', 'IME');
Select insert_do (8, 18, '01-02-2011', 'B18', 'T45', 'Luiz Gonçalvez', 'IME');
Select insert_do (1, 19, '01-02-2010', 'B19', 'T45', 'Luiz Gonçalvez', 'IME');

SELECT insert_rel_dis_mod (1, 1, 'O');
SELECT insert_rel_dis_mod (2, 1, 'O');
SELECT insert_rel_dis_mod (3, 2, 'O');
SELECT insert_rel_dis_mod (4, 2, 'E');
SELECT insert_rel_dis_mod (5, 3, 'E');
SELECT insert_rel_dis_mod (6, 1, 'L');
SELECT insert_rel_dis_mod (7, 5, 'O');
SELECT insert_rel_dis_mod (8, 6, 'O');
SELECT insert_rel_dis_mod (9, 9, 'L');
SELECT insert_rel_dis_mod (10, 1, 'O');

SELECT insert_prereq (1, 1, 'MAT0101 - Cálculo 1');
SELECT insert_prereq (2, 1, 'MAT0101 - Cálculo 1');
SELECT insert_prereq (3, 2, 'MAT0102 - Cálculo 2');
SELECT insert_prereq (4, 2, 'MAT0102 - Cálculo 2');
SELECT insert_prereq (5, 3, 'MAT0103 - Cálculo 3');
SELECT insert_prereq (6, 1, 'MAT0103 - Cálculo 3');
SELECT insert_prereq (7, 5, 'MAT0103 - Cálculo 3');
SELECT insert_prereq (8, 6, 'MAC0101 - Introdução à Computação 1');
SELECT insert_prereq (9, 9, 'MAC0101 - Introdução à Computação 1');
SELECT insert_prereq (10, 1, 'MAC0101 - Introdução à Computação 1')






