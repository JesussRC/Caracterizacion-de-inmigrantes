/*==============================================================*/
/* DBMS name:      PostgreSQL 8                                 */
/* Autor:     Jesús David Reyes Carreño                         */
/*==============================================================*/


drop table CLIENTE;

drop table ESTADIA;

drop table GENERO;

drop table NACIONALIDAD;

drop table REFERENCIA;

drop table REGISTRO;

drop table REGISTRO_FAMILIAR;

drop table SUPERVISOR;

drop table UNID_CONTROL;

/*==============================================================*/
/* Table: CLIENTE                                               */
/*==============================================================*/
create table CLIENTE (
   CLIENTE_ID           INT4                 not null,
   NACIONALIDAD_ID      VARCHAR(3)           not null,
   GENERO_ID            VARCHAR(1)           not null,
   CLIENTE_PASAPORTE    VARCHAR(10)          not null,
   CLIENTE_NOMBRE       VARCHAR(50)          not null,
   CLIENTE_APELLIDO     VARCHAR(50)          not null,
   CLIENTE_FECHA_NACIMIENTO DATE                 not null,
   CLIENTE_DNI          VARCHAR(10)          not null,
   CLIENTE_APLICA_PAR_NA VARCHAR(2)           not null,
   CLIENTE_PROFESION    VARCHAR(50)          not null,
   constraint PK_CLIENTE primary key (CLIENTE_ID)
);

/*==============================================================*/
/* Table: ESTADIA                                               */
/*==============================================================*/
create table ESTADIA (
   ESTADIA_ID           INT4                 not null,
   REFERENCIA_ID        INT4                 null,
   ESTADIA_TIEMPO_DIAS  VARCHAR(10)          not null,
   ESTADIA_CIUDAD       VARCHAR(50)          not null,
   constraint PK_ESTADIA primary key (ESTADIA_ID)
);

/*==============================================================*/
/* Table: GENERO                                                */
/*==============================================================*/
create table GENERO (
   GENERO_ID            VARCHAR(1)           not null,
   GENERO_DESCRIPCION   VARCHAR(50)          not null,
   constraint PK_GENERO primary key (GENERO_ID)
);

/*==============================================================*/
/* Table: NACIONALIDAD                                          */
/*==============================================================*/
create table NACIONALIDAD (
   NACIONALIDAD_ID      VARCHAR(3)           not null,
   NACIONALIDAD_DESCRIPCION VARCHAR(50)          not null,
   constraint PK_NACIONALIDAD primary key (NACIONALIDAD_ID)
);

/*==============================================================*/
/* Table: REFERENCIA                                            */
/*==============================================================*/
create table REFERENCIA (
   REFERENCIA_ID        INT4                 not null,
   REFERENCIA_NOMBRE    VARCHAR(50)          not null,
   REFERENCIA_APELLIDO  VARCHAR(50)          not null,
   REFERENCIA_DNI       VARCHAR(10)          not null,
   REFERENCIA_TELEFONO  VARCHAR(10)          not null,
   REFERENCIA_DIRECCION VARCHAR(50)          not null,
   constraint PK_REFERENCIA primary key (REFERENCIA_ID)
);

/*==============================================================*/
/* Table: REGISTRO                                              */
/*==============================================================*/
create table REGISTRO (
   REGISTRO_ID          INT4                 not null,
   CLIENTE_ID           INT4                 not null,
   SUPERVISOR_ID        INT4                 not null,
   UNID_CONTROL_ID      VARCHAR(4)                 not null,
   ESTADIA_ID           INT4                 not null,
   REGISTRO_MOTIVO_INGRESO VARCHAR(50)          not null,
   REGISTRO_SITUACION_ECONOMICA VARCHAR(50)          not null,
   REGISTRO_APLICA_AYUDA_SO VARCHAR(2)           not null,
   REGISTRO_FECHA_REGISTRO DATE                 not null,
   REGISTRO_FECHA_INGRESO DATE                 not null,
   REGISTRO_FECHA_SALIDA DATE                 not null,
   REGISTRO_INGRESO_FAMILIAR BOOL                 not null,
   constraint PK_REGISTRO primary key (REGISTRO_ID)
);

/*==============================================================*/
/* Table: REGISTRO_FAMILIAR                                     */
/*==============================================================*/
create table REGISTRO_FAMILIAR (
   REGISTRO_FAM_ID      INT4                 not null,
   REGISTRO_ID          INT4                 not null,
   CLIENTE_ID           INT4                 not null,
   REGISTRO_FAM_NOMBRE  VARCHAR(50)          not null,
   REGISTRO_FAM_APELLIDO VARCHAR(50)          not null,
   REGISTRO_FAM_DNI     VARCHAR(10)          not null,
   REGISTRO_FAM_PARENTESCO VARCHAR(50)          not null,
   constraint PK_REGISTRO_FAMILIAR primary key (REGISTRO_FAM_ID, REGISTRO_ID, CLIENTE_ID)
);

/*==============================================================*/
/* Table: SUPERVISOR                                            */
/*==============================================================*/
create table SUPERVISOR (
   SUPERVISOR_ID        INT4                 not null,
   SUPERVISOR_CARGO     VARCHAR(50)          not null,
   SUPERVISOR_NOMBRE    VARCHAR(50)          not null,
   SUPERVISOR_APELLIDO  VARCHAR(50)          not null,
   SUPERVISOR_DNI       VARCHAR(10)          not null,
   SUPERVISOR_TELEFONO  VARCHAR(10)          not null,
   SUPERVISOR_FECHA_NACIMIENTO DATE                 not null,
   constraint PK_SUPERVISOR primary key (SUPERVISOR_ID)
);

/*==============================================================*/
/* Table: UNID_CONTROL                                          */
/*==============================================================*/
create table UNID_CONTROL (
   UNID_CONTROL_ID      VARCHAR(4)                 not null,
   UNID_CONTROL_DESCRIPCION VARCHAR(50)          not null,
   constraint PK_UNID_CONTROL primary key (UNID_CONTROL_ID)
);

alter table CLIENTE
   add constraint FK_CLIENTE_RELATIONS_NACIONAL foreign key (NACIONALIDAD_ID)
      references NACIONALIDAD (NACIONALIDAD_ID)
      on delete restrict on update restrict;

alter table CLIENTE
   add constraint FK_CLIENTE_RELATIONS_GENERO foreign key (GENERO_ID)
      references GENERO (GENERO_ID)
      on delete restrict on update restrict;

alter table ESTADIA
   add constraint FK_ESTADIA_RELATIONS_REFERENC foreign key (REFERENCIA_ID)
      references REFERENCIA (REFERENCIA_ID)
      on delete restrict on update restrict;

alter table REGISTRO
   add constraint FK_REGISTRO_RELATIONS_CLIENTE foreign key (CLIENTE_ID)
      references CLIENTE (CLIENTE_ID)
      on delete restrict on update restrict;

alter table REGISTRO
   add constraint FK_REGISTRO_RELATIONS_UNID_CON foreign key (UNID_CONTROL_ID)
      references UNID_CONTROL (UNID_CONTROL_ID)
      on delete restrict on update restrict;

alter table REGISTRO
   add constraint FK_REGISTRO_RELATIONS_SUPERVIS foreign key (SUPERVISOR_ID)
      references SUPERVISOR (SUPERVISOR_ID)
      on delete restrict on update restrict;

alter table REGISTRO
   add constraint FK_REGISTRO_RELATIONS_ESTADIA foreign key (ESTADIA_ID)
      references ESTADIA (ESTADIA_ID)
      on delete restrict on update restrict;

alter table REGISTRO_FAMILIAR
   add constraint FK_REGISTRO_RELATIONS_CLIENTE foreign key (CLIENTE_ID)
      references CLIENTE (CLIENTE_ID)
      on delete restrict on update restrict;

alter table REGISTRO_FAMILIAR
   add constraint FK_REGISTRO_RELATIONS_REGISTRO foreign key (REGISTRO_ID)
      references REGISTRO (REGISTRO_ID)
      on delete restrict on update restrict;

