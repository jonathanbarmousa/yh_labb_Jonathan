SELECT * FROM "Person_info";
SELECT * FROM "FriståendeKurs";
SELECT * FROM "Program";
SELECT * FROM "Anläggning";
SELECT * FROM "Företag";
SELECT * FROM "Utbildare";
SELECT * FROM "Student";
SELECT * FROM "Klass";
SELECT * FROM "Kurs";
SELECT * FROM "Utbildningsledare";
SELECT * FROM "Student_fristående_kurs";

DROP TABLE IF EXISTS "Student_fristående_kurs" CASCADE;
DROP TABLE IF EXISTS "Klass" CASCADE;
DROP TABLE IF EXISTS "Kurs" CASCADE;
DROP TABLE IF EXISTS "Student" CASCADE;
DROP TABLE IF EXISTS "Utbildare" CASCADE;
DROP TABLE IF EXISTS "Utbildningsledare" CASCADE;
DROP TABLE IF EXISTS "Företag" CASCADE;
DROP TABLE IF EXISTS "Anläggning" CASCADE;
DROP TABLE IF EXISTS "Program" CASCADE;
DROP TABLE IF EXISTS "FriståendeKurs" CASCADE;
DROP TABLE IF EXISTS "Person_info" CASCADE;

CREATE TABLE IF NOT EXISTS "Person_info" (
  "Person_info_id" SERIAL PRIMARY KEY,
  "Personnummer" VARCHAR(20),
  "E-post" VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS "FriståendeKurs" (
  "Fristående_kurs_id" SERIAL PRIMARY KEY,
  "Kursnamn" VARCHAR(100),
  "Kurskod" VARCHAR(50) UNIQUE,
  "Beskrivning" TEXT
);

CREATE TABLE IF NOT EXISTS "Program" (
  "Programnamn" VARCHAR(100),
  "Kurskod" VARCHAR(50) UNIQUE,
  "Antalpoäng" INT,
  "Beskrivning" TEXT
);

CREATE TABLE IF NOT EXISTS "Anläggning" (
  "Anläggnings_id" SERIAL PRIMARY KEY,
  "Stad" VARCHAR(100),
  "Plats" VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS "Företag" (
  "Företags_id" SERIAL PRIMARY KEY,
  "Företagsnamn" VARCHAR(100),
  "Org_nummer" VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS "Utbildare" (
  "Utbildar_id" SERIAL PRIMARY KEY,
  "Person_id" INT,
  "Företag_id" INT,
  "Förnamn" VARCHAR(100),
  "Efternamn" VARCHAR(100),
  "E-post" VARCHAR(100),
  "Anställningsform" VARCHAR(50),
  FOREIGN KEY ("Person_id") REFERENCES "Person_info"("Person_info_id"),
  FOREIGN KEY ("Företag_id") REFERENCES "Företag"("Företags_id")
);

CREATE TABLE IF NOT EXISTS "Student" (
  "Student_id" SERIAL PRIMARY KEY,
  "Person_id" INT,
  "Förnamn" VARCHAR(100),
  "Efternamn" VARCHAR(100),
  "Friståendekurs_id" INT,
  FOREIGN KEY ("Person_id") REFERENCES "Person_info"("Person_info_id"),
  FOREIGN KEY ("Friståendekurs_id") REFERENCES "FriståendeKurs"("Fristående_kurs_id")
);

CREATE TABLE IF NOT EXISTS "Klass" (
  "Klass_id" SERIAL PRIMARY KEY,
  "Utbildningsledare_id" INT,
  "Klassnamn" VARCHAR(100),
  "Klasskod" VARCHAR(50),
  "Start_och_slut_datum" DATE,
  FOREIGN KEY ("Utbildningsledare_id") REFERENCES "Utbildare"("Utbildar_id")
);

CREATE TABLE IF NOT EXISTS "Kurs" (
  "Kurs_id" SERIAL PRIMARY KEY,
  "Konsult_id" INT,
  "Utbildar_id" INT,
  "Kursnamn" VARCHAR(100),
  "Kurskod" VARCHAR(50),
  "Beskrivning" TEXT,
  FOREIGN KEY ("Utbildar_id") REFERENCES "Utbildare"("Utbildar_id")
);

CREATE TABLE IF NOT EXISTS "Utbildningsledare" (
  "Utbildar_id" SERIAL PRIMARY KEY,
  "Person_id" INT,
  "Förnamn" VARCHAR(100),
  "Efternamn" VARCHAR(100),
  FOREIGN KEY ("Person_id") REFERENCES "Person_info"("Person_info_id")
);

CREATE TABLE IF NOT EXISTS "Student_fristående_kurs" (
  "Student_id" INT,
  "Friståendekurs_id" INT,
  FOREIGN KEY ("Student_id") REFERENCES "Student"("Student_id"),
  FOREIGN KEY ("Friståendekurs_id") REFERENCES "FriståendeKurs"("Fristående_kurs_id")
);

INSERT INTO "Person_info" ("Personnummer", "E-post")
VALUES 
  ('19850101-1234', 'bob.alice@email.com'),
  ('198500202-5678', 'alice.bob@email.com');

INSERT INTO "FriståendeKurs" ("Kursnamn", "Kurskod", "Beskrivning")
VALUES 
  ('Webbutveckling', 'WB101', 'En kurs om webbutveckling med fokus på frontend och backend'),
  ('Databashantering', 'DB102', 'En kurs om databaser och SQL-programmering');

INSERT INTO "Program" ("Programnamn", "Kurskod", "Antalpoäng", "Beskrivning")
VALUES 
  ('Webbprogrammering', 'WB101', 30, 'Program för att lära sig webbutveckling'),
  ('Databashantering', 'DB102', 25, 'Program för att lära sig databashantering och SQL');

INSERT INTO "Anläggning" ("Stad", "Plats")
VALUES 
  ('Stockholm', 'STI Liljeholmen'),
  ('Götebrog', 'GTI Göteholmen');

INSERT INTO "Företag" ("Företagsnamn", "Org_nummer")
VALUES 
  ('Equinix', '556677-8899'),
  ('Stegra', '556833-1122');

INSERT INTO "Utbildare" ("Person_id", "Företag_id", "Förnamn", "Efternamn", "E-post", "Anställningsform")
VALUES 
  (1, 1, 'Bob', 'Johansson', 'bob.johansson@email.com', 'Heltid'),
  (2, 2, 'Alice', 'Karlsson', 'alice.karlsson@email.com', 'Deltid');

INSERT INTO "Student" ("Person_id", "Förnamn", "Efternamn", "Friståendekurs_id")
VALUES 
  (1, 'Bob', 'Svensson', 1),
  (2, 'Alice', 'Larsson', 2);

INSERT INTO "Klass" ("Utbildningsledare_id", "Klassnamn", "Klasskod", "Start_och_slut_datum")
VALUES 
  (1, 'Webbutveckling A Bob', 'WB101A', '2025-05-01'),
  (2, 'Databashantering A Alice', 'DB102A', '2025-06-01');

INSERT INTO "Kurs" ("Konsult_id", "Utbildar_id", "Kursnamn", "Kurskod", "Beskrivning")
VALUES 
  (1, 1, 'Webbutveckling för nybörjare', 'WB101N', 'En introduktion till webbutveckling'),
  (2, 2, 'Avancerad Databashantering', 'DB102B', 'En kurs om avancerad användning av SQL och databaser');

INSERT INTO "Utbildningsledare" ("Person_id", "Förnamn", "Efternamn")
VALUES 
  (1, 'Bob', 'Johansson'),
  (2, 'Alice', 'Karlsson');

INSERT INTO "Student_fristående_kurs" ("Student_id", "Friståendekurs_id")
VALUES 
  (1, 1),
  (2, 2);

