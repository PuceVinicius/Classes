create type endereco as
(
	cep varchar(8),
	RUA varchar(255),
	RUA_NUM integer,
	comp varchar(100)
);

create type id_ministra as
    (
        NUSProf integer,
        ID_DISCIPLINA varchar(20),
        Periodo daterange
);

create function cpf_validar(par_cpf character varying) returns integer
	language plpgsql
    as $$
    DECLARE
        x real;
        y real;
        soma integer;
        dig1 integer;
        dig2 integer;
        len integer;
        contloop integer;
        val_par_cpf varchar(11);
    BEGIN
        IF char_length(par_cpf) = 11 THEN
        ELSE
            RAISE NOTICE 'Formato inv�lido: %',$1;
            RETURN 0;
        END IF;
        x := 0;
        soma := 0;
        dig1 := 0;
        dig2 := 0;
        contloop := 0;
        val_par_cpf := $1;
        len := char_length(val_par_cpf);
        x := len -1;

        contloop :=1;
        WHILE contloop <= (len -2) LOOP
            y := CAST(substring(val_par_cpf from contloop for 1) AS NUMERIC);
            soma := soma + ( y * x);
            x := x - 1;
            contloop := contloop +1;
        END LOOP;
        dig1 := 11 - CAST((soma % 11) AS INTEGER);
        if (dig1 = 10) THEN dig1 :=0 ; END IF;
        if (dig1 = 11) THEN dig1 :=0 ; END IF;


        x := 11; soma :=0;
        contloop :=1;
        WHILE contloop <= (len -1) LOOP
            soma := soma + CAST((substring(val_par_cpf FROM contloop FOR 1)) AS REAL) * x;
            x := x - 1;
            contloop := contloop +1;
        END LOOP;
        dig2 := 11 - CAST ((soma % 11) AS INTEGER);
        IF (dig2 = 10) THEN dig2 := 0; END IF;
        IF (dig2 = 11) THEN dig2 := 0; END IF;
        --Teste do CPF
        IF ((dig1 || '' || dig2) = substring(val_par_cpf FROM len-1 FOR 2)) THEN
            RETURN 1;
        ELSE
            RAISE NOTICE 'DV do CPF Inv�lido: %',$1;
            RETURN 0;
        END IF;
    END;
    $$;

create table curriculo
(
	"CURSO" integer not null
		constraint "Currículo_pkey"
			primary key,
	"Periodo" daterange,
	"Grade" varchar(20) [] not null
);

create index "Currículo_CURSO"
	on curriculo ("CURSO");

create table "Perfil"
(
	"PERFIL" integer not null
		constraint "Perfil_pkey"
			primary key
);

create index "Perfil_PERFIL"
	on "Perfil" ("PERFIL");

create table "Trilha"
(
	"ID_TRILHA" varchar(2) not null
		constraint "Trilha_pkey"
			primary key,
	"Nome" varchar(255) not null
);

create table rel_cur_tri
(
	"Curso" integer not null
		constraint "rel_cur_tri_currículo__fk"
			references curriculo
				on update cascade on delete cascade,
	"ID_TRILHA" varchar(2) not null
		constraint rel_cur_tri_trilha__fk
			references "Trilha",
	"Disciplinas" varchar(20) [] not null
);

create index "rel_cur_tri_ID"
	on rel_cur_tri ("Curso");

create index "rel_cur_tri_ID_TRILHA"
	on rel_cur_tri ("ID_TRILHA");

create index "Trilha_ID_TRILHA"
	on "Trilha" ("ID_TRILHA");

create table "Disciplina"
(
	"ID_DISCIPLINA" varchar(20) not null
		constraint "Disciplina_pkey"
			primary key,
	"PeriodoAtiva" daterange,
	"Instituto" varchar(255) not null,
	"CredTrab" varchar(2) not null,
	"CredAula" varchar(2) not null,
	nome varchar(255) not null
);

create table modulo
(
	"Nome" varchar(255) not null,
	"ID_MODULO" varchar(2) not null
		constraint "Módulo_pkey"
			primary key,
	"ID_TRILHA" varchar(255)
);

create index "Módulo_ID_TRILHA"
	on modulo ("ID_TRILHA");

create index "Módulo_ID_MÓDULO"
	on modulo ("ID_MODULO");

create table rel_dis_mod
(
	id_modulo varchar(2) not null
		constraint rel_dis_mod_modulo__fk
			references modulo
				on update cascade on delete cascade,
	id_discplina varchar(20) not null
		constraint rel_dis_mod_disciplina__fk
			references "Disciplina",
	nat char not null
		constraint rel_dis_mod_nat_check
			check (nat = ANY (ARRAY['O'::bpchar, 'E'::bpchar, 'L'::bpchar, 'X'::bpchar]))
);

create table servico
(
	"ID_SERVICO" integer not null
		constraint "Serviço_pkey"
			primary key
		constraint "servico_ID_SERVICO_check"
			check (("ID_SERVICO" >= 0) AND ("ID_SERVICO" <= 99)),
	"DESC" varchar(255) not null
);

create table pf_se
(
	"PERFIL" integer not null
		constraint pf_se_perfil__fk
			references "Perfil"
				on update cascade on delete cascade,
	"SERVICO" integer not null
		constraint pf_se_servico__fk
			references servico,
	"DESC" varchar(255) not null
);

create index "Serviço_ID_"
	on servico ("ID_SERVICO");

create table "Pessoa"
(
	"CPF" text not null
		constraint "Pessoa_pkey"
			primary key
		constraint "Pessoa_CPF_check"
			check (cpf_validar(("CPF")::character varying) = 1),
	"Nome" varchar(255) not null,
	"NASCI" date not null,
	"Email" varchar(255),
	"Sexo" char
		constraint "Pessoa_Sexo_check"
			check ("Sexo" = ANY (ARRAY['M'::bpchar, 'H'::bpchar, 'N'::bpchar])),
	"Idade" integer,
	"Endereco" endereco not null
);

create table "Administrador"
(
	"NUSP" integer not null
		constraint check_nusp
			check (("NUSP" > 0) AND ("NUSP" < 999999999)),
	"Perfil" varchar(255),
	cpf varchar(11) not null
		constraint administrador_pessoa__fk
			references "Pessoa"
	    constraint "Administrador_pkey"
			primary key
		constraint "Administrador_cpf_check"
			check (cpf_validar(cpf) = 1)
);

create unique index administrador_cpf_uindex
	on "Administrador" (cpf);

create table usuario
(
	"Login" varchar(255) not null
		constraint "Usuário_pkey"
			primary key,
	"CPF" varchar(11) not null
		constraint usuario_pessoa__fk
			references "Pessoa",
	"Senha" varchar(255) not null,
	"Email" varchar(255) not null
);

create table us_pf
(
	"LOGIN" varchar(255) not null
		constraint us_pf_usuario__fk
			references usuario
				on update cascade on delete cascade,
	"PERFIL" integer not null
		constraint us_pf_perfil__fk
			references "Perfil"
);

create table "Aluno"
(
	"NUSP" integer not null
		constraint "Aluno_NUSP_check"
			check (("NUSP" > 0) AND ("NUSP" <= 999999999)),
	"Curso" varchar(255),
	cpf varchar(11) not null
	    constraint "Aluno_pkey"
			primary key
		constraint aluno_pessoa__fk
			references "Pessoa"
		constraint "Aluno_cpf_check"
			check (cpf_validar(cpf) = 1)
);

create table "Planeja"
(
	"cpf" varchar(11) not null
		constraint planeja_aluno__fk
			references "Aluno",
	"ID_DISCIPLINA" varchar(20) not null
		constraint planeja_disciplina__fk
			references "Disciplina"
				on update cascade on delete cascade,
	"Periodo" date
);

create index "Planeja_ID_DISCIPLINA"
	on "Planeja" ("ID_DISCIPLINA");

create unique index aluno_cpf_uindex
	on "Aluno" (cpf);

create table "Professor"
(
	"NUSP" integer not null
		constraint "Professor_NUSP_check"
			check (("NUSP" > 0) AND ("NUSP" <= 999999999)),
	"CPF" varchar(11) not null
	    constraint "Professor_pkey"
			primary key
		constraint professor_pessoa__fk
			references "Pessoa"
		constraint "Professor_CPF_check"
			check (cpf_validar("CPF") = 1),
	"Espec" varchar(255)
);

create unique index professor_cpf_uindex
	on "Professor" ("CPF");

create table "Administra"
(
	"cpf" varchar(11) not null
		constraint administra_administrador__fk
			references "Administrador",
	"Curso" integer not null
		constraint administra_curriculo__fk
			references curriculo,
	"Periodo" daterange
);

create unique index administra_adm_nusp_uindex
	on "Administra" ("cpf");

create table "Ministra"
(
	"Periodo" daterange not null,
	"ID_MINISTRA" id_ministra not null
		constraint "Ministra_pkey"
			primary key,
	"Horario" time without time zone[] not null,
	"Monitor" integer,
	"Turma" varchar(255) not null,
	"Sala" varchar(255),
	"CPF" varchar(11) not null
		constraint ministra_professor__fk
			references "Professor",
	"ID_DISCIPLINA" varchar(255)
		constraint ministra_disciplina__fk
			references "Disciplina"
);


create table periodo_curriculo
(
	id_curso integer not null
		constraint periodo_curriculo_curriculo__fk
			references curriculo,
	periodo date
);

create table DISCIPLINAS_REL_CUR_TRI
(
	id_curso integer not null
		constraint DISCIPLINAS_REL_CUR_TRI_curriculo__fk
			references curriculo,
	id_trilha varchar(2) not null
        constraint DISCIPLINAS_REL_CUR_TRI_trilha__fk
            references "Trilha"
);

create table PERMISSOES_PERFIL
(
	id_perfil integer not null
		constraint PERMISSOES_PERFIL_perfil__fk
			references "Perfil",
    permissoes bool[]
);

create table GRADE_CURRICULO
(
	id_curso integer not null
		constraint periodo_curriculo_curriculo__fk
			references curriculo,
	id_disciplina varchar(20) not null
        constraint grade_curriculo_disciplina__fk
            references "Disciplina"
);

create table PERIODO_DISCIPLINA
(
	id_disciplina varchar(20) not null
        constraint grade_curriculo_disciplina__fk
            references "Disciplina",
    periodo date
);

create table PREREQ_REL_DIS_MOD
(
	id_modulo varchar not null
		constraint PREREQ_REL_DIS_MOD_modulo__fk
			references modulo,
	id_disciplina varchar(20) not null
        constraint grade_curriculo_disciplina__fk
            references "Disciplina",
    prereq varchar
);


create index "Ministra_ID_DISCIPLINA"
	on "Ministra" ("ID_DISCIPLINA");

create index "Ministra_ID_MINISTRA"
	on "Ministra" ("ID_MINISTRA");

create table "Cursa"
(
	"Status" varchar(2),
	"Nota" double precision
		constraint "Cursa_Nota_check"
			check (("Nota" >= (0)::double precision) AND ("Nota" <= (10)::double precision)),
	"Frequencia" double precision
		constraint "Cursa_Frequencia_check"
			check (("Frequencia" <= (1)::double precision) AND ("Frequencia" >= (0)::double precision)),
	"cpf" varchar(11) not null
		constraint cursa_aluno__fk
			references "Aluno",
	"ID_MINISTRA" id_ministra not null
		constraint cursa_ministra__fk
			references "Ministra"
);

create index "Cursa_ID_MINISTRA"
	on "Cursa" ("ID_MINISTRA");

create index "Pessoa_Idade"
	on "Pessoa" ("NASCI");

create index "Pessoa_Idade1"
	on "Pessoa" ("Idade");
