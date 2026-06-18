-- ══════════════════════════════════════════════
-- CURSO AGENCIA IA — Tablas en Supabase Airmate
-- Ejecutar en el SQL Editor de Supabase
-- ══════════════════════════════════════════════

-- Alumnos con acceso (se añaden manualmente tras el pago)
CREATE TABLE IF NOT EXISTS curso_alumnos (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  email TEXT NOT NULL UNIQUE,
  name TEXT,
  enrolled_at TIMESTAMPTZ DEFAULT NOW(),
  notes TEXT, -- "pagó 97€ el 2026-06-18 por WhatsApp"
  active BOOLEAN DEFAULT true
);

-- Módulos del curso
CREATE TABLE IF NOT EXISTS curso_modulos (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT,
  order_num INTEGER NOT NULL,
  published BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Lecciones dentro de cada módulo
CREATE TABLE IF NOT EXISTS curso_lecciones (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  module_id UUID REFERENCES curso_modulos(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  content TEXT, -- HTML con el contenido de la lección
  video_url TEXT, -- URL embed (YouTube: https://www.youtube.com/embed/ID)
  duration_min INTEGER, -- duración estimada en minutos
  order_num INTEGER NOT NULL,
  published BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Preguntas de repaso al final de cada lección
CREATE TABLE IF NOT EXISTS curso_preguntas (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  lesson_id UUID REFERENCES curso_lecciones(id) ON DELETE CASCADE,
  question TEXT NOT NULL,
  options JSONB NOT NULL, -- ["opción A", "opción B", "opción C", "opción D"]
  correct_index INTEGER NOT NULL, -- 0-3
  explanation TEXT, -- explicación de la respuesta correcta
  order_num INTEGER DEFAULT 0
);

-- Progreso de cada alumno
CREATE TABLE IF NOT EXISTS curso_progreso (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  alumno_email TEXT NOT NULL,
  lesson_id UUID REFERENCES curso_lecciones(id) ON DELETE CASCADE,
  completed_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(alumno_email, lesson_id)
);

-- Notas personales de cada alumno por lección
CREATE TABLE IF NOT EXISTS curso_notas (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  alumno_email TEXT NOT NULL,
  lesson_id UUID REFERENCES curso_lecciones(id) ON DELETE CASCADE,
  content TEXT,
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(alumno_email, lesson_id)
);

-- ══════════════════════════════════════════════
-- RLS Policies (ejecutar después de crear las tablas)
-- ══════════════════════════════════════════════

ALTER TABLE curso_alumnos ENABLE ROW LEVEL SECURITY;
ALTER TABLE curso_modulos ENABLE ROW LEVEL SECURITY;
ALTER TABLE curso_lecciones ENABLE ROW LEVEL SECURITY;
ALTER TABLE curso_preguntas ENABLE ROW LEVEL SECURITY;
ALTER TABLE curso_progreso ENABLE ROW LEVEL SECURITY;
ALTER TABLE curso_notas ENABLE ROW LEVEL SECURITY;

-- Módulos y lecciones: lectura pública (el login lo gestiona el frontend)
CREATE POLICY "modulos_read" ON curso_modulos FOR SELECT USING (published = true);
CREATE POLICY "lecciones_read" ON curso_lecciones FOR SELECT USING (published = true);
CREATE POLICY "preguntas_read" ON curso_preguntas FOR SELECT USING (true);

-- Progreso y notas: cualquiera puede leer/escribir (controlado por email en el frontend)
CREATE POLICY "progreso_all" ON curso_progreso FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "notas_all" ON curso_notas FOR ALL USING (true) WITH CHECK (true);

-- Alumnos: solo lectura por email (el frontend verifica si tiene acceso)
CREATE POLICY "alumnos_read" ON curso_alumnos FOR SELECT USING (true);
-- Escritura solo con service role (desde el panel de mentor)

-- ══════════════════════════════════════════════
-- DATOS INICIALES — Módulos y lecciones del curso
-- ══════════════════════════════════════════════

INSERT INTO curso_modulos (title, description, order_num) VALUES
('Bienvenida y mentalidad', 'Por qué esto funciona y qué necesitas para empezar', 1),
('El mercado y el nicho', 'Cómo elegir a quién ayudas y qué problema resuelves', 2),
('Qué vender y cómo montarlo', 'Los tres servicios, precios y la parte técnica real', 3),
('Conseguir clientes', 'Outreach, llamada de descubrimiento y cierre', 4),
('Los errores que cometí', 'Lo que no haría de nuevo y por qué', 5),
('El sistema de trabajo', 'Herramientas, flujos y cómo escalar siendo uno solo', 6),
('Mentorías y comunidad', 'Acceso directo, preguntas y seguimiento', 7);

-- Lección de bienvenida
INSERT INTO curso_lecciones (module_id, title, content, order_num, duration_min)
SELECT id,
  'Mi historia real (sin adornar)',
  '<h2>De Tenerife a Dubai</h2>
<p>Empecé esto desde Tenerife. Sin carrera, sin contactos en tecnología, sin dinero ahorrado para "invertir en el negocio". Lo que tenía era tiempo, acceso a internet y una idea que no me dejaba dormir.</p>
<p>Mi primer cliente fue un conocido al que le monté algo básico prácticamente gratis. Un agente de WhatsApp para su barbería. Tardé tres semanas, cobré 150€ de setup y 50€/mes. Trabajé como un burro. Lo usó dos meses y lo canceló.</p>
<p>Eso me dejó K.O. una semana. Luego me levanté y cambié el enfoque completamente. Y en los siguientes meses conseguí a Jose Acosta, a Ricardo, a Magda, a El Maestro, a Costa Norte. Viajé a Dubai a reunirme con House of Tailors.</p>
<p>Ninguno de esos clientes vino de una estrategia perfecta. Todos vinieron de hacer las cosas que da pereza hacer, bien y de forma consistente.</p>
<p>Esto es exactamente lo que hice.</p>',
  1, 8
FROM curso_modulos WHERE order_num = 1;
