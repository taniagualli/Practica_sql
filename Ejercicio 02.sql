Ejercicio 02 - Script Bdd Keepcoding

CREATE TABLE public.Profesor (
                profesor_id INTEGER NOT NULL,
                profesor_nombre VARCHAR(100) NOT NULL,
                profesor_apellido VARCHAR(100) NOT NULL,
                profesor_mail VARCHAR(50) NOT NULL,
                profesor_telefono INTEGER NOT NULL,
                CONSTRAINT profesor_id PRIMARY KEY (profesor_id)
);


CREATE TABLE public.Alumno (
                alumno_id INTEGER NOT NULL,
                alumno_nombre VARCHAR(100) NOT NULL,
                alumno_apellido VARCHAR(100) NOT NULL,
                alumno_mail VARCHAR(50) NOT NULL,
                alumno_telefono INTEGER NOT NULL,
                CONSTRAINT alumno_id PRIMARY KEY (alumno_id)
);


CREATE TABLE public.Bootcamp (
                bootcamp_id INTEGER NOT NULL,
                bootcamp_nombre VARCHAR(100) NOT NULL,
                bootcamp_edicion VARCHAR(10) NOT NULL,
                bootcamp_formato VARCHAR(20) NOT NULL,
                bootcamp_fecha_inicio DATE NOT NULL,
                bootcamp_duracion VARCHAR(20) NOT NULL,
                bootcamp_director VARCHAR(100) NOT NULL,
                CONSTRAINT bootcamp_id PRIMARY KEY (bootcamp_id)
);


CREATE TABLE public.Modulo (
                modulo_id INTEGER NOT NULL,
                bootcamp_id INTEGER NOT NULL,
                profesor_id INTEGER NOT NULL,
                modulo_nombre VARCHAR(100) NOT NULL,
                modulo_formato VARCHAR(20) NOT NULL,
                modulo_duracion VARCHAR(20) NOT NULL,
                modulo_contenido VARCHAR(1000) NOT NULL,
                CONSTRAINT modulo_id PRIMARY KEY (modulo_id, bootcamp_id, profesor_id)
);


CREATE TABLE public.Calificaciones (
                alumno_id INTEGER NOT NULL,
                modulo_id INTEGER NOT NULL,
                bootcamp_id INTEGER NOT NULL,
                calificaciones_id INTEGER NOT NULL,
                nota1 NUMERIC(2,2) NOT NULL,
                nota2 NUMERIC(2,2) NOT NULL,
                aprueba VARCHAR(2) NOT NULL,
                CONSTRAINT calificaciones_id PRIMARY KEY (alumno_id, modulo_id, bootcamp_id)
);


ALTER TABLE public.Modulo ADD CONSTRAINT profesor_modulo_fk
FOREIGN KEY (profesor_id)
REFERENCES public.Profesor (profesor_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Calificaciones ADD CONSTRAINT alumno_calificaciones_fk
FOREIGN KEY (alumno_id)
REFERENCES public.Alumno (alumno_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Modulo ADD CONSTRAINT bootcamp_modulo_fk
FOREIGN KEY (bootcamp_id)
REFERENCES public.Bootcamp (bootcamp_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Calificaciones ADD CONSTRAINT modulo_calificaciones_fk
FOREIGN KEY (modulo_id, bootcamp_id)
REFERENCES public.Modulo (modulo_id, bootcamp_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
