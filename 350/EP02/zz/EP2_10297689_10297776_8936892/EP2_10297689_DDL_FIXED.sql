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

create table "User"
(
	us_id integer not null
		constraint "Usuario_pkey"
			primary key,
	us_email varchar(255) not null,
	us_password varchar(255) not null
);

create table "Pessoa"
(
	"ID_Pessoa" integer not null
		constraint "Pessoa_pkey"
			primary key,
	"CPF" text not null
		constraint "Pessoa_CPF_check"
			check (cpf_validar(("CPF")::character varying) = 1),
	"Nome" varchar(255) not null,
	us_id integer
		constraint us_pf_usuario__fk
			references "User"
				on update cascade on delete cascade
);

create table "Curriculo"
(
	"Curso" integer not null
		constraint "Curriculo_pkey"
			primary key,
	"Nome" varchar(20) not null
);

create index "Curriculo_CURSO"
	on "Curriculo" ("Curso");

create table "Perfil"
(
	"Perfil" integer not null
		constraint "Perfil_pkey"
			primary key,
	"Nome" varchar(255)
);


create index "Perfil_PERFIL"
	on "Perfil" ("Perfil");

create table "Trilha"
(
	"ID_Trilha" integer not null
		constraint "Trilha_pkey"
			primary key,
	"Nome" varchar(255) not null
);

create index "Trilha_ID_Trilha"
	on "Trilha" ("ID_Trilha");

create table "Rel_Cur_Tri"
(
	"Curso" integer not null
		constraint "Rel_Cur_Tri_curriculo__fk"
			references "Curriculo"
				on update cascade on delete cascade,
	"ID_Trilha" integer not null
		constraint Rel_Cur_Tri_trilha__fk
			references "Trilha"
);


create index "Rel_Cur_Tri_ID"
	on "Rel_Cur_Tri" ("Curso");

create index "Rel_Cur_Tri_ID_Trilha"
	on "Rel_Cur_Tri" ("ID_Trilha");

create table "Disciplina_Info"
(
	"Disc_ID" integer not null
		constraint "Disciplina_pkey"
			primary key,
	"Desc" varchar(255) not null,
	"CR_A" integer not null,
	"CR_T" integer not null,
	"Nome" varchar(255) not null
);

create table "Modulo"
(
	"Nome" varchar(255) not null,
	"ID_Modulo" integer not null
		constraint "Modulo_pkey"
			primary key,
	"ID_Trilha" integer not null
        constraint "Modulo_fkey"
            references "Trilha"
);

create index "Modulo_ID_Trilha"
	on "Modulo" ("ID_Trilha");

create index "Modulo_ID_Modulo"
	on "Modulo" ("ID_Modulo");

create table "Rel_Dis_Mod"
(
	"ID_Modulo" integer not null
		constraint rel_dis_mod_modulo__fk
			references "Modulo"
				on update cascade on delete cascade,
	"Disc_ID" integer not null
		constraint rel_dis_mod_disciplina__fk
			references "Disciplina_Info",
	"Nat" char not null
		constraint rel_dis_mod_nat_check
			check ("Nat" = ANY (ARRAY['O'::bpchar, 'E'::bpchar, 'L'::bpchar, 'X'::bpchar]))
);

create table "Servico"
(
	"ID_Servico" integer not null
		constraint "Servico_pkey"
			primary key
		constraint "servico_ID_Servico_check"
			check (("ID_Servico" >= 0) AND ("ID_Servico" <= 99)),
	"Desc" varchar(255),
	"Nome" varchar(255)
);

create index "Servico_ID_"
	on "Servico" ("ID_Servico");

create table pf_se
(
	"Perfil" integer not null
		constraint pf_se_perfil__fk
			references "Perfil"
				on update cascade on delete cascade,
	"ID_Servico" integer not null
		constraint pf_se_servico__fk
			references "Servico"
);



create table "Administrador"
(
	"NUSP" integer not null
		constraint check_nusp
			check (("NUSP" > 0) AND ("NUSP" < 999999999)),
	"Perfil" integer not null,
	"ID_Pessoa" integer not null
		constraint "Administrador_pkey"
			primary key
		constraint administrador_pessoa__fk
			references "Pessoa"
);

create unique index administrador_id_pessoa_uindex
	on "Administrador" ("ID_Pessoa");



create table us_pf
(
	us_id integer not null
		constraint us_pf_usuario__fk
			references "User"
				on update cascade on delete cascade,
	"Perfil" integer not null
		constraint us_pf_perfil__fk
			references "Perfil"
);

create table "Aluno"
(
	"NUSP" integer not null
		constraint "Aluno_NUSP_check"
			check (("NUSP" > 0) AND ("NUSP" <= 999999999)),
	"Curso" integer not null
	    constraint "Aluno_Curso__fk"
	        references "Curriculo",
	"ID_Pessoa" integer not null
		constraint "Aluno_pkey"
			primary key
		constraint aluno_pessoa__fk
			references "Pessoa"
);

create unique index aluno_id_pessoa_uindex
	on "Aluno" ("ID_Pessoa");

create table "Planeja"
(
	"ID_Pessoa" integer not null
		constraint planeja_aluno__fk
			references "Aluno",
	"Disc_ID" integer not null
		constraint planeja_disciplina__fk
			references "Disciplina_Info"
				on update cascade on delete cascade
);

create index "Planeja_Disc_ID"
	on "Planeja" ("Disc_ID");

create table "Professor"
(
	"NUSP" integer not null
		constraint "Professor_NUSP_check"
			check (("NUSP" > 0) AND ("NUSP" <= 999999999)),
	"ID_Pessoa" integer not null
		constraint "Professor_pkey"
			primary key
		constraint professor_pessoa__fk
			references "Pessoa",
	"Especializacao" varchar(255)
);

create unique index professor_id_pessoa_uindex
	on "Professor" ("ID_Pessoa");

create table "Administra"
(
	"ID_Pessoa" integer not null
		constraint administra_administrador__fk
			references "Administrador",
	"Curso" integer not null
		constraint administra_curriculo__fk
			references "Curriculo",
	"Prd" date
);

create unique index administra_adm_nusp_uindex
	on "Administrador" ("ID_Pessoa");

create table "Disciplina_Oferecimento"
(
	"Instituto" varchar(255) not null,
	"Prd" date not null,
	"Monitor" varchar(255),
	"Turma" varchar(255) not null,
	"Sala" varchar(255),
	"ID_Pessoa" integer not null
		constraint ministra_professor__fk
			references "Professor",
	"Disc_ID" integer
		constraint ministra_disciplina__fk
			references "Disciplina_Info",
    PRIMARY KEY ("Disc_ID", "ID_Pessoa", "Prd")
);

create index "Ministra_Disc_ID"
	on "Disciplina_Oferecimento" ("Disc_ID");

create index "Ministra_ID_MINISTRA"
	on "Disciplina_Oferecimento" ("ID_Pessoa");

create table "Periodo_Curriculo"
(
	"Curso" integer not null
		constraint periodo_curriculo_curriculo__fk
			references "Curriculo",
	"Prd" date
);

create table "Disciplinas_Rel_Cur_Tri"
(
	"Curso" integer not null
		constraint disciplinas_rel_cur_tri_curriculo__fk
			references "Curriculo",
	"ID_Trilha" integer not null
		constraint disciplinas_rel_cur_tri_trilha__fk
			references "Trilha",
    "Disc_ID" integer not null
        constraint disciplinas_rel_cur_tri_disciplina__fk
            references "Disciplina_Info"
);

create table "Grade_Curriculo"
(
	"Curso" integer not null
		constraint grade_curriculo_curriculo_curso_fk
			references "Curriculo"
				on update cascade on delete cascade,
	"Disc_ID" integer not null
);

create table "Periodo_Disciplina"
(
	"Disc_ID" integer not null
		constraint grade_curriculo_disciplina__fk
			references "Disciplina_Info",
	"Prd" date
);

create table "Prereq_Rel_Dis_Mod"
(
	"ID_Modulo" integer not null
		constraint prereq_rel_dis_mod_modulo__fk
			references "Modulo",
	"Disc_ID" integer not null
		constraint grade_curriculo_disciplina__fk
			references "Disciplina_Info",
	"Prereq" varchar
);

create table "Cursa"
(
	"Status" varchar(2),
	"Nota" double precision
		constraint "Cursa_Nota_check"
			check (("Nota" >= (0)::double precision) AND ("Nota" <= (10)::double precision)),
	"Frequencia" double precision
		constraint "Cursa_Frequencia_check"
			check (("Frequencia" <= (1)::double precision) AND ("Frequencia" >= (0)::double precision)),
	"ID_Professor" integer not null
	    constraint cursa_professor__fk
			references "Aluno",
	"Disc_ID" integer not null
		constraint cursa_aluno__fk
			references "Disciplina_Info",
	"ID_Aluno" integer not null
		constraint cursa_aluno__2fk
			references "Aluno",
	"Prd" date not null,
    PRIMARY KEY ("ID_Aluno",  "Prd",  "Disc_ID",  "ID_Professor")
);


create table "Oferecimento"
(
    "ID_Professor" integer not null
        constraint ofereciment_professor__fk
			references "Professor",
    "Disc_ID" integer not null
        constraint ofereciment_disciplina__fk
			references "Disciplina_Info",
    "Prd" date not null
)
