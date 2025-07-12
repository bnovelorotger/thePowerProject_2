# Proyecto SQL – Análisis y Consultas de Base de Datos

## 1. Objetivo

El proyecto consistió en realizar un conjunto de consultas SQL sobre una base de datos de películas, alquileres y clientes, con el fin de extraer información útil para la gestión y análisis de datos empresariales.

---

## 2. Pasos Seguidos

1. **Análisis inicial de la base de datos**  
   Se examinó el esquema para entender las tablas principales (`film`, `actor`, `category`, `customer`, `rental`, `staff`, etc.) y las relaciones entre ellas.

2. **Diseño y desarrollo de consultas**  
   Se elaboraron consultas con diferentes objetivos: cálculos estadísticos, filtrado de datos, uso de funciones agregadas, subconsultas, joins internos y externos, y creación de vistas y tablas temporales.

3. **Corrección y optimización**  
   Se resolvieron errores comunes (tipos de datos, conversiones, alias, sintaxis), y se optimizó el uso de joins para evitar resultados incorrectos o redundantes.

4. **Documentación**  
   Cada consulta se comentó con su número y enunciado para facilitar su comprensión y revisión.

---

## 3. Análisis y Conclusiones

- **Importancia del entendimiento del esquema:**  
  Comprender las relaciones entre tablas es fundamental para escribir consultas precisas y eficientes, especialmente en bases de datos relacionales complejas.

- **Uso adecuado de joins:**  
  La elección entre `INNER JOIN`, `LEFT JOIN` y `CROSS JOIN` impacta directamente en los resultados. Por ejemplo, un `CROSS JOIN` genera combinaciones cartesianas que pueden no aportar valor si no se usan con cuidado.

- **Manejo de tipos de datos:**  
  La manipulación correcta de tipos, como fechas y números, es crucial para evitar errores y obtener resultados coherentes.

- **Consultas agregadas y subconsultas:**  
  Las funciones agregadas (`COUNT`, `AVG`, `SUM`) junto con subconsultas permiten análisis estadísticos útiles para la toma de decisiones.

- **Creación de vistas y tablas temporales:**  
  Estas herramientas facilitan la reutilización y segmentación del trabajo, mejorando la mantenibilidad y claridad del proyecto.

---

## 4. Recomendaciones

- **Validación básica de datos:**  
  Revisar que no existan duplicados ni datos inconsistentes en las tablas clave para asegurar la precisión de los resultados.

- **Documentación clara:**  
  Mantener comentarios claros en las consultas y un archivo README que explique el propósito y alcance de cada consulta facilita la comprensión y revisión.

- **Uso adecuado de joins y filtros:**  
  Seleccionar correctamente el tipo de join (`INNER`, `LEFT`, `CROSS`) y aplicar filtros precisos para obtener resultados coherentes y evitar datos irrelevantes.

- **Optimización simple:**  
  Para consultas que impliquen grandes volúmenes, considerar índices básicos y evitar subconsultas innecesarias para mejorar el rendimiento.

---

## 5. Archivos entregados

- `ddl.sql`: Script con la definición del esquema de la base de datos (tablas, claves primarias y foráneas).
- `consultas_entrega.sql`: Archivo con todas las consultas implementadas, comentadas y numeradas.
- `README.md`: Este documento que recoge el proceso y análisis.

---

Si se requiere, estoy disponible para ampliar el análisis, realizar nuevas consultas o ajustar el proyecto a requisitos específicos.

---

Autor
**Bernardo Novelo Rotger**  
 
