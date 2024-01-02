-- 11. Retorna un llistat amb els professors/es que tenen un departament associat i que no imparteixen cap assignatura.
SELECT profesor.id_profesor, persona.nombre, persona.apellido1, persona.apellido2
FROM universidad.profesor
JOIN universidad.persona ON profesor.id_profesor = persona.id
LEFT JOIN universidad.asignatura ON profesor.id_profesor = asignatura.id_profesor
WHERE asignatura.id_profesor IS NULL;