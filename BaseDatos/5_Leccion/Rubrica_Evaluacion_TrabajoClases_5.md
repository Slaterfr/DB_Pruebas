# Rubrica Evaluacion Trabajo de Clases 5

**Tema:** Evaluación de la calidad de una base de datos operacional
**Base de datos:** `databaseLeccion5.sqlite` (suministrada por el profesor)

### 1. Descripción general

El objetivo es evaluar la **calidad estructural y funcional** de la base de datos **`databaseLeccion5`** utilizando métricas cuantificables y criterios técnicos aplicados a las ciencias de la computación.

### 2. Actividades a realizar

1. **Explorar la base de datos:**

   * Listar **todas las tablas** que contiene.
   * Describir las **relaciones** entre ellas (claves primarias y foráneas).
   * Enumerar las **columnas con su respectivo tipo de dato** de cada tabla.

2. **Analizar el modelo de datos:**

   * Identificar si el modelo corresponde a un **modelo en estrella (Star Schema)** o **copo de nieve (Snowflake Schema)** y justificar la elección.

3. **Evaluar la calidad de los datos:**

   * Identificar **valores únicos, duplicados y atípicos** en las tablas principales.
   * Medir la **velocidad de ejecución de consultas** (latencia en lecturas).
   * Validar si existen y se utilizan **metadatos**.
   * Cuantificar la **latencia en operaciones de escritura o inserción**.
   * Comprobar si las **claves primarias presentan duplicados**.
   * Verificar el cumplimiento de las **reglas de negocio** definidas por las relaciones entre tablas.

4. **Documentar los hallazgos:**

   * Presentar scrit con el codigo SQL utilizados para realizar las pruebas.
   * Elaborar documento MD con **conclusión técnica** sobre la calidad de la base de datos.

---

## 📊 Tabla de Rúbrica de Evaluación

| Criterio                                    | Descripción                                            | Ponderación |
| ------------------------------------------- | ------------------------------------------------------ | ----------- |
| Identificación de tablas y relaciones       | Listado correcto y descripción estructural completa    | 15%         |
| Tipos de datos y claves                     | Análisis correcto de columnas, PK y FK                 | 10%         |
| Determinación del modelo de datos           | Justificación técnica clara (estrella o copo de nieve) | 10%         |
| Análisis de duplicados, únicos y atípicos   | Identificación mediante consultas SQL                  | 15%         |
| Medición de velocidad y latencia            | Evidencia cuantificada de desempeño                    | 15%         |
| Validación de reglas de negocio y metadatos | Coherencia e integridad de la base                     | 15%         |
| Presentación y claridad del informe         | Orden, lenguaje técnico y conclusiones                 | 20%         |
| **Total**                                   |                                                        | **100%**    |

---
