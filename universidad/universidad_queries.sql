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
SELECT departamento.nombre AS departamento, persona.apellido1, persona.apellido2, persona.nombre AS nombre FROM universidad.profesor LEFT JOIN universidad.departamento ON profesor.id_departamento = departamento.id RIGHT JOIN universidad.persona ON persona.id = profesor.id_profesor ORDER BY departamento.nombre ASC, persona.apellido1 ASC, persona.apellido2 ASC, persona.nombre ASC;

-- 2. Retorna un llistat amb els professors/es que no estan associats a un departament.
SELECT persona.nombre, persona.apellido1, persona.apellido2 FROM universidad.profesor LEFT JOIN universidad.departamento ON profesor.id_departamento = departamento.id RIGHT JOIN universidad.persona ON persona.id = profesor.id_profesor WHERE departamento.nombre IS NULL;

-- 3. Retorna un llistat amb els departaments que no tenen professors/es associats.
SELECT DISTINCT departamento.nombre FROM universidad.departamento 
LEFT JOIN universidad.profesor ON profesor.id_departamento = departamento.id
WHERE profesor.id_departamento IS NULL;

-- 4. Retorna un llistat amb els professors/es que no imparteixen cap assignatura.
SELECT persona.nombre AS nombre_profesor, persona.apellido1, persona.apellido2, asignatura.nombre AS asignatura FROM universidad.profesor RIGHT JOIN universidad.persona ON profesor.id_profesor = persona.id LEFT JOIN universidad.asignatura ON profesor.id_profesor = asignatura.id_profesor WHERE asignatura.id_profesor IS NULL;

-- 5. Retorna un llistat amb les assignatures que no tenen un professor/a assignat.
SELECT nombre FROM universidad.asignatura WHERE id_profesor IS NULL;

-- 6. Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar.
SELECT departamento.nombre AS departamento FROM universidad.departamento LEFT JOIN universidad.profesor ON departamento.id = profesor.id_departamento LEFT JOIN universidad.asignatura ON profesor.id_profesor = asignatura.id_profesor GROUP BY departamento.nombre HAVING MAX(asignatura.id) IS NULL;

    --MAX(asignatura.id) devuelve el valor más grande de asignatura.id para cada grupo. Si un departamento no ha impartido ninguna asignatura, entonces todos los valores de asignatura.id para ese departamento serán NULL, y el valor máximo también será NULL.
    -- Por lo tanto, HAVING MAX(asignatura.id) IS NULL incluirá solo los departamentos que no han impartido ninguna asignatura, ya que para ellos, el valor máximo de asignatura.id será NULL.

Por lo tanto, HAVING MAX(asignatura.id) IS NULL incluirá solo los departamentos que no han impartido ninguna asignatura, ya que para ellos, el valor máximo de asignatura.id será NULL.


-- >> Consultes resum:

-- 1. Retorna el nombre total d'alumnes que hi ha.
SELECT COUNT(*) FROM universidad.persona WHERE tipo = 'alumno';

-- 2. Calcula quants alumnes van néixer en 1999.
SELECT COUNT(*) FROM universidad.persona WHERE tipo = 'alumno' AND YEAR(fecha_nacimiento) = 1999;

-- 3. Calcula quants professors/es hi ha en cada departament. El resultat només ha de mostrar dues columnes, una amb el nom del departament i una altra amb el nombre de professors/es que hi ha en aquest departament. El resultat només ha d'incloure els departaments que tenen professors/es associats i haurà d'estar ordenat de major a menor pel nombre de professors/es.
SELECT departamento.nombre AS departamento, COUNT(profesor.id_profesor) AS numero_profesores FROM universidad.departamento JOIN universidad.profesor ON departamento.id = profesor.id_departamento GROUP BY departamento.nombre HAVING COUNT(profesor.id_profesor) > 0 ORDER BY COUNT(profesor.id_profesor) DESC;

-- 4. Retorna un llistat amb tots els departaments i el nombre de professors/es que hi ha en cadascun d'ells. Tingui en compte que poden existir departaments que no tenen professors/es associats. Aquests departaments també han d'aparèixer en el llistat.
SELECT departamento.nombre AS departamento, GROUP_CONCAT(CONCAT(persona.nombre, ' ', persona.apellido1, ' ', persona.apellido2)) AS profesores FROM universidad.departamento LEFT JOIN universidad.profesor ON departamento.id = profesor.id_departamento LEFT JOIN universidad.persona ON profesor.id_profesor = persona.id AND persona.tipo = 'profesor' GROUP BY departamento.nombre;

-- 5. Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun. Tingues en compte que poden existir graus que no tenen assignatures associades. Aquests graus també han d'aparèixer en el llistat. El resultat haurà d'estar ordenat de major a menor pel nombre d'assignatures.
SELECT grado.nombre AS grado, GROUP_CONCAT(asignatura.nombre ORDER BY asignatura.nombre DESC) AS asignaturas FROM universidad.grado LEFT JOIN universidad.asignatura ON grado.id = asignatura.id_grado GROUP BY grado.nombre;

-- 6. Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun, dels graus que tinguin més de 40 assignatures associades.
SELECT grado.nombre AS grado, COUNT(asignatura.nombre) AS numero_de_asignaturas
FROM universidad.grado LEFT JOIN universidad.asignatura ON grado.id = asignatura.id_grado GROUP BY grado.nombre ORDER BY numero_de_asignaturas DESC;

    -- >> NO ENTIENDO MUY BIEN LA 2ª PARTE DE LA PREGUNTA SOBRE LAS 40 ASIGNATURAS, abajo la version que creo correcta pero entonces no listo todos los GRADOS:
SELECT grado.nombre AS grado, COUNT(asignatura.nombre) AS numero_de_asignaturas
FROM universidad.grado 
LEFT JOIN universidad.asignatura ON grado.id = asignatura.id_grado
GROUP BY grado.nombre
HAVING numero_de_asignaturas > 40;

-- 7. Retorna un llistat que mostri el nom dels graus i la suma del nombre total de crèdits que hi ha per a cada tipus d'assignatura. El resultat ha de tenir tres columnes: nom del grau, tipus d'assignatura i la suma dels crèdits de totes les assignatures que hi ha d'aquest tipus.
SELECT grado.nombre AS nombre_grado, asignatura.tipo AS tipo_asignatura, SUM(asignatura.creditos) AS suma_de_creditos FROM universidad.grado LEFT JOIN universidad.asignatura ON grado.id = asignatura.id_grado GROUP BY grado.nombre, asignatura.tipo;

    -- La cláusula GROUP BY agrupa los resultados por las columnas grado.nombre y asignatura.tipo. Significa que para cada combinación única de nombre de grado y tipo de asignatura, se sumarán los créditos de las asignaturas correspondientes.

-- 8. Retorna un llistat que mostri quants alumnes s'han matriculat d'alguna assignatura en cadascun dels cursos escolars. El resultat haurà de mostrar dues columnes, una columna amb l'any d'inici del curs escolar i una altra amb el nombre d'alumnes matriculats.
SELECT curso_escolar.anyo_inicio, COUNT(alumno_se_matricula_asignatura.id_alumno) AS numero_alumnos_matriculados FROM universidad.curso_escolar LEFT JOIN universidad.alumno_se_matricula_asignatura ON curso_escolar.id = alumno_se_matricula_asignatura.id_curso_escolar GROUP BY curso_escolar.anyo_inicio;

-- 9. Retorna un llistat amb el nombre d'assignatures que imparteix cada professor/a. El llistat ha de tenir en compte aquells professors/es que no imparteixen cap assignatura. El resultat mostrarà cinc columnes: id, nom, primer cognom, segon cognom i nombre d'assignatures. El resultat estarà ordenat de major a menor pel nombre d'assignatures.
SELECT profesor.id_profesor AS id, persona.nombre AS nombre, persona.apellido1, persona.apellido2, COUNT(asignatura.nombre) AS numero_de_asignaturas FROM universidad.profesor LEFT JOIN universidad.persona ON profesor.id_profesor = persona.id LEFT JOIN universidad.asignatura ON profesor.id_profesor = asignatura.id_profesor GROUP BY profesor.id_profesor ORDER BY numero_de_asignaturas DESC;

-- 10. Retorna totes les dades de l'alumne/a més jove.
SELECT * FROM universidad.persona WHERE persona.tipo = 'alumno' ORDER BY fecha_nacimiento ASC LIMIT 1;

-- 11. Retorna un llistat amb els professors/es que tenen un departament associat i que no imparteixen cap assignatura.
SELECT profesor.id_profesor, persona.nombre, persona.apellido1, persona.apellido2 FROM universidad.profesor JOIN universidad.persona ON profesor.id_profesor = persona.id LEFT JOIN universidad.asignatura ON profesor.id_profesor = asignatura.id_profesor WHERE asignatura.id_profesor IS NULL;