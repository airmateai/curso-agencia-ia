# Librería de prompts para Claude

Copia y adapta — sustituye lo que está entre [corchetes] por los datos reales de tu proyecto.

---

## Desarrollo — arrancar un proyecto nuevo

> Quiero construir un panel CRM para [tipo de negocio, ej. "una barbería premium"]. Necesita gestionar: [lista, ej. "clientes, citas, historial de servicios, facturación básica"]. Usa Supabase como base de datos y autenticación, HTML+CSS+JS puro sin frameworks, todo en un solo archivo. Antes de escribir código, hazme las preguntas que necesites sobre el negocio para diseñarlo bien.

## Desarrollo — añadir una función a algo que ya existe

> Aquí tienes el archivo [nombre del archivo]. Quiero añadir [descripción exacta de la función nueva]. No toques nada más de lo que ya funciona. Antes de escribir el código, explícame en 2-3 frases cómo lo vas a hacer para que lo confirme.

## Debugging — algo no funciona

> Esto debería hacer [comportamiento esperado] pero en su lugar pasa [comportamiento real que ves]. Aquí está el error de la consola: [pega el error]. Aquí está el código relevante: [pega la función/sección]. Encuentra la causa raíz antes de proponer un cambio — no me des una solución hasta que entiendas exactamente por qué pasa esto.

## Debugging — algo va lento / se cuelga

> Este panel se ralentiza / se cuelga después de [tiempo/acción]. Revisa el código buscando específicamente: intervalos (setInterval) que se acumulen, clientes o conexiones que se creen repetidamente sin cerrarse, bucles que crezcan sin límite, o renderizados innecesarios. Dime qué encuentras antes de arreglar nada.

## Seguridad — auditoría rápida

> Revisa este archivo buscando: claves o contraseñas escritas directamente en el código, comparaciones de contraseña en el propio navegador en vez de en un servidor, tablas de Supabase sin Row Level Security, y cualquier dato personal que se pueda leer sin haber iniciado sesión. Dame una lista priorizada de lo que encuentres, no lo arregles todavía.

## Diseño — mejorar el aspecto de algo

> Esta sección se ve [problema, ej. "sobrecargada", "poco profesional", "desalineada en móvil"]. El tono de marca que quiero es [ej. "premium, sobrio, sin exceso de colores"]. Propón cambios concretos de CSS, no reescribas el HTML entero salvo que sea necesario.

## Marketing — generar ideas de contenido

> Dame 10 ideas de contenido para [red social] para alguien que vende [tu servicio] a [tu nicho]. El tono debe ser directo, sin frases de "gurú de curso", basado en resultados reales, no en teoría genérica. Para cada idea, dime en una frase el gancho de los primeros 2 segundos.

## Ventas — preparar una llamada de descubrimiento

> Voy a tener una llamada con [tipo de negocio]. Su web/redes dicen [pega lo que sepas de ellos]. Ayúdame a preparar 2-3 preguntas específicas para este negocio en concreto, además de las 4 preguntas base de descubrimiento, que demuestren que he investigado su caso.

## Ventas — responder una objeción por escrito

> Un cliente potencial me ha dicho por WhatsApp: "[pega el mensaje exacto del cliente]". Ayúdame a responder sin bajar el precio, sin sonar a la defensiva, y abriendo la puerta a resolver la duda real que hay detrás.
