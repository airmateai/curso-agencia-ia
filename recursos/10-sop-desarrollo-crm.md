# SOP — Desarrollo de un CRM, de la reunión a la entrega

Procedimiento técnico paso a paso para construir un CRM a medida, desde la primera reunión hasta la entrega final.

## 1. Análisis (antes de tocar código)
- [ ] ¿Qué gestiona el negocio hoy y con qué herramientas (Excel, papel, WhatsApp, otro software)?
- [ ] ¿Qué datos necesita guardar por cliente? (nombre, contacto, historial, medidas/preferencias específicas del sector)
- [ ] ¿Necesita citas/reservas? ¿Facturación? ¿Stock? ¿Varios usuarios con distintos permisos?
- [ ] ¿Cuántas personas van a usar el sistema y qué rol tiene cada una?

## 2. Diseño de la base de datos
- [ ] Listar las tablas necesarias (clientes, encargos/citas, facturas, stock si aplica)
- [ ] Definir qué columna identifica el negocio si el proyecto comparte base de datos con otros clientes (business_slug)
- [ ] Activar Row Level Security desde el principio, no como algo que se añade "después" (módulo 23)

## 3. Usuarios y permisos
- [ ] Decidir si hay un solo login o varios roles (ej. dueño ve todo, empleado ve solo lo suyo)
- [ ] Login server-side con hash de contraseña, nunca comparación en el navegador
- [ ] Sesión con renovación automática (refresh token), no que caduque cada hora sin avisar

## 4. Módulos funcionales (uno a la vez, no todos juntos)
- [ ] Módulo de clientes primero — es el núcleo de casi cualquier CRM
- [ ] Módulo de citas/encargos después
- [ ] Facturación, si aplica
- [ ] Stock/inventario, si aplica
- [ ] Estadísticas/dashboard al final — es la parte menos crítica funcionalmente

## 5. Panel de administración
- [ ] Vista clara de lo más urgente (citas de hoy, clientes sin seguimiento, stock bajo)
- [ ] Acciones rápidas accesibles sin muchos clics

## 6. Notificaciones
- [ ] Confirmaciones automáticas por email (EmailJS) para citas/pedidos
- [ ] Recordatorios si aplica al negocio (citas del día siguiente, por ejemplo)

## 7. Antes de entregar
- [ ] Probar como si fueras el cliente, en móvil y en ordenador
- [ ] Revisar que no hay contraseñas ni claves de prueba visibles
- [ ] Auditoría rápida de RLS (módulo 23.5)
- [ ] Documento técnico interno escrito

## 8. Mantenimiento y escalabilidad
- [ ] Definir qué incluye el mantenimiento mensual por escrito (recurso 01)
- [ ] Guardar el proyecto como base para reutilizar en el próximo cliente del mismo sector
