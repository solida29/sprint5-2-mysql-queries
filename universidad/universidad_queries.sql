-- UNIVERSIDAD QUERIES

-- 1. Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els/les alumnes. El llistat haurà d'estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom i nom.
SELECT apellido1, apellido2, nombre FROM universidad.persona WHERE tipo = 'alumno' ORDER BY apellido1 ASC;

-- 2. Esbrina el nom i els dos cognoms dels alumnes que no han donat d'alta el seu número de telèfon en la base de dades.
SELECT nombre, apellido1, apellido2 FROM universidad.persona WHERE tipo = 'alumno' AND telefono IS NULL;

-- 3. Retorna el llistat dels alumnes que van néixer en 1999.
SELECT nombre, apellido1, apellido2 FROM universidad.persona WHERE tipo = 'alumno' AND YEAR(fecha_nacimiento) = 1999;

-- 4. Retorna el llistat de professors/es que no han donat d'alta el seu número de telèfon en la base de dades i a més el seu NIF acaba en K.
SELECT nombre, apellido1, apellido2 FROM universidad.persona WHERE tipo = 'profesor' AND telefono IS NULL AND nif LIKE '%K';

-- 5. Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre, en el tercer curs del grau que té l'identificador 7.
SELECT nombre FROM universidad.asignatura WHERE cuatrimestre = 1 AND curso = 3 AND id_grado = 7;

-- 6. Retorna un llistat dels professors/es juntament amb el nom del departament al qual estan vinculats. El llistat ha de retornar quatre columnes, primer cognom, segon cognom, nom i nom del departament. El resultat estarà ordenat alfabèticament de menor a major pels cognoms i el nom.
SELECT persona.apellido1, persona.apellido2, persona.nombre AS nombre, departamento.nombre AS departamento FROM universidad.persona JOIN universidad.profesor ON persona.id = profesor.id_profesor JOIN universidad.departamento ON profesor.id_departamento = departamento.idORDER BY persona.apellido1 ASC, persona.apellido2 ASC, persona.nombre ASC;

-- 7. Retorna un llistat amb el nom de les assignatures, any d'inici i any de fi del curs escolar de l'alumne/a amb NIF 26902806M.
SELECT persona.nombre, asignatura.nombre AS asignatura, curso_escolar.anyo_inicio, curso_escolar.anyo_fin FROM universidad.asignatura INNER JOIN universidad.alumno_se_matricula_asignatura ON asignatura.id = alumno_se_matricula_asignatura.id_asignaturaINNER JOIN universidad.persona ON persona.id = alumno_se_matricula_asignatura.id_alumnoINNER JOIN universidad.curso_escolar ON alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.idWHERE persona.nif = '26902806M';

-- 8. Retorna un llistat amb el nom de tots els departaments que tenen professors/es que imparteixen alguna assignatura en el Grau en Enginyeria Informàtica (Pla 2015).
SELECT DISTINCT departamento.nombre FROM universidad.departamento JOIN universidad.profesor ON departamento.id = profesor.id_departamento JOIN universidad.asignatura ON profesor.id_profesor = asignatura.id_profesor JOIN universidad.grado ON asignatura.id_grado = grado.id WHERE grado.nombre = 'Grado en Ingeniería Informática (Plan 2015)';

    -- >> 8. para comprobar los datos
    SELECT departamento.nombre, asignatura.nombre, profesor.id_profesor, grado.nombre FROM universidad.departamento 
    JOIN universidad.profesor ON departamento.id = profesor.id_departamento
    JOIN universidad.asignatura ON profesor.id_profesor = asignatura.id_profesor
    JOIN universidad.grado ON asignatura.id_grado = grado.id
    WHERE grado.nombre = 'Grado en Ingeniería Informática (Plan 2015)';

-- 9. Retorna un llistat amb tots els alumnes que s'han matriculat en alguna assignatura durant el curs escolar 2018/2019.
SELECT DISTINCT persona.* FROM universidad.persona INNER JOIN universidad.alumno_se_matricula_asignatura ON persona.id = alumno_se_matricula_asignatura.id_alumno INNER JOIN universidad.curso_escolar ON alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id WHERE curso_escolar.anyo_inicio = 2018 AND curso_escolar.anyo_fin = 2019;

-- >> Resol les 6 següents consultes utilitzant les clàusules LEFT JOIN i RIGHT JOIN.

-- 1. Retorna un llistat amb els noms de tots els professors/es i els departaments que tenen vinculats. El llistat també ha de mostrar aquells professors/es que no tenen cap departament associat. El llistat ha de retornar quatre columnes, nom del departament, primer cognom, segon cognom i nom del professor/a. El resultat estarà ordenat alfabèticament de menor a major pel nom del departament, cognoms i el nom.

-- 2. Retorna un llistat amb els professors/es que no estan associats a un departament.

-- 3. Retorna un llistat amb els departaments que no tenen professors/es associats.

-- 4. Retorna un llistat amb els professors/es que no imparteixen cap assignatura.

-- 5. Retorna un llistat amb les assignatures que no tenen un professor/a assignat.

-- 6. Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar.


-- >> Consultes resum:

-- 1. Retorna el nombre total d'alumnes que hi ha.

-- 2. Calcula quants alumnes van néixer en 1999.

-- 3. Calcula quants professors/es hi ha en cada departament. El resultat només ha de mostrar dues columnes, una amb el nom del departament i una altra amb el nombre de professors/es que hi ha en aquest departament. El resultat només ha d'incloure els departaments que tenen professors/es associats i haurà d'estar ordenat de major a menor pel nombre de professors/es.

-- 4. Retorna un llistat amb tots els departaments i el nombre de professors/es que hi ha en cadascun d'ells. Tingui en compte que poden existir departaments que no tenen professors/es associats. Aquests departaments també han d'aparèixer en el llistat.

-- 5. Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun. Tingues en compte que poden existir graus que no tenen assignatures associades. Aquests graus també han d'aparèixer en el llistat. El resultat haurà d'estar ordenat de major a menor pel nombre d'assignatures.

-- 6. Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun, dels graus que tinguin més de 40 assignatures associades.

-- 7. Retorna un llistat que mostri el nom dels graus i la suma del nombre total de crèdits que hi ha per a cada tipus d'assignatura. El resultat ha de tenir tres columnes: nom del grau, tipus d'assignatura i la suma dels crèdits de totes les assignatures que hi ha d'aquest tipus.

-- 8. Retorna un llistat que mostri quants alumnes s'han matriculat d'alguna assignatura en cadascun dels cursos escolars. El resultat haurà de mostrar dues columnes, una columna amb l'any d'inici del curs escolar i una altra amb el nombre d'alumnes matriculats.

-- 9. Retorna un llistat amb el nombre d'assignatures que imparteix cada professor/a. El llistat ha de tenir en compte aquells professors/es que no imparteixen cap assignatura. El resultat mostrarà cinc columnes: id, nom, primer cognom, segon cognom i nombre d'assignatures. El resultat estarà ordenat de major a menor pel nombre d'assignatures.

-- 10. Retorna totes les dades de l'alumne/a més jove.

-- 11. Retorna un llistat amb els professors/es que tenen un departament associat i que no imparteixen cap assignatura.