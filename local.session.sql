-- >> Resol les 6 següents consultes utilitzant les clàusules LEFT JOIN i RIGHT JOIN.

-- 6. Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar.



-- >> Consultes resum:

-- 3. Calcula quants professors/es hi ha en cada departament. El resultat només ha de mostrar dues columnes, una amb el nom del departament i una altra amb el nombre de professors/es que hi ha en aquest departament. El resultat només ha d'incloure els departaments que tenen professors/es associats i haurà d'estar ordenat de major a menor pel nombre de professors/es.

SELECT departamento.nombre AS nombre_departamento, COUNT(profesor.id_profesor) AS numero_profesores
FROM universidad.departamento
JOIN universidad.profesor ON departamento.id = profesor.id_departamento
WHERE COUNT(profesor.id_profesor) > 0
ORDER BY COUNT(profesor.id_profesor) DESC;