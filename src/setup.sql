CREATE TABLE organization (
    organization_id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    description TEXT NOT NULL,
    contact_email VARCHAR(255) NOT NULL,
    logo_filename VARCHAR(255) NOT NULL
);

INSERT INTO organization (name, description, contact_email, logo_filename) VALUES
('BrightFuture Builders', 'A nonprofit focused on improving community infrastructure through sustainable construction projects.', 'info@brightfuturebuilders.org', 'brightfuture-logo.png'),
('GreenHarvest Growers', 'An urban farming collective promoting food sustainability and education in local neighborhoods.', 'contact@greenharvest.org', 'greenharvest-logo.png'),
('UnityServe Volunteers', 'A volunteer coordination group supporting local charities and service initiatives.', 'hello@unityserve.org', 'unityserve-logo.png');

CREATE TABLE projects (
    project_id SERIAL PRIMARY KEY,
    organization_id INTEGER NOT NULL,
    title VARCHAR(150) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(255) NOT NULL,
    date DATE NOT NULL,
    FOREIGN KEY (organization_id) REFERENCES organization (organization_id)
);

INSERT INTO projects (organization_id, title, description, location, date) VALUES
-- Projetos da BrightFuture Builders (ID: 1)
(1, 'School Renovation', 'Repairing local school facilities.', 'Downtown', '2023-11-15'),
(1, 'Bridge Painting', 'Fresh coat of paint for the community bridge.', 'West River', '2023-12-01'),
(1, 'Park Bench Install', 'Adding new benches to the city park.', 'Central Park', '2024-01-10'),
(1, 'Solar Lighting', 'Installing solar lights in public paths.', 'North Trail', '2024-02-20'),
(1, 'Roof Repair Workshop', 'Teaching locals how to repair roofs.', 'Community Center', '2024-03-05'),

-- Projetos da GreenHarvest Growers (ID: 2)
(2, 'Urban Garden Planting', 'Planting seasonal vegetables.', 'East Side', '2023-11-20'),
(2, 'Composting Seminar', 'Learning about organic waste recycling.', 'Library Hall', '2023-12-15'),
(2, 'Hydroponics Setup', 'Setting up water-based growing systems.', 'Tech Lab', '2024-01-25'),
(2, 'Fruit Tree Harvest', 'Picking ripe fruits for the food bank.', 'South Orchard', '2024-02-15'),
(2, 'Seed Swap Event', 'Exchanging seeds with local gardeners.', 'Town Square', '2024-03-12'),

-- Projetos da UnityServe Volunteers (ID: 3)
(3, 'Food Drive Support', 'Organizing donations for local families.', 'Main Warehouse', '2023-11-25'),
(3, 'Senior Home Visit', 'Spending time with elderly residents.', 'Golden Days Home', '2023-12-20'),
(3, 'Beach Cleanup', 'Removing trash from the coastline.', 'Sunset Beach', '2024-01-30'),
(3, 'Clothing Donation', 'Sorting clothes for those in need.', 'Shelter Hub', '2024-02-28'),
(3, 'Youth Mentoring', 'Helping students with their homework.', 'City Library', '2024-03-20');

CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

INSERT INTO categories (name) VALUES
('Construction'),
('Environment'),
('Education'),
('Community'),
('Food');

-- Tabela intermediária: um projeto pode ter várias categorias e vice-versa
CREATE TABLE project_categories (
    project_id INTEGER NOT NULL,
    category_id INTEGER NOT NULL,
    PRIMARY KEY (project_id, category_id),
    FOREIGN KEY (project_id) REFERENCES projects (project_id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES categories (category_id) ON DELETE CASCADE
);

INSERT INTO project_categories (project_id, category_id) VALUES
(1,1),(1,3),
(2,1),(2,4),
(3,1),(3,2),(3,4),
(4,1),(4,2),
(5,1),(5,3),
(6,2),(6,5),
(7,2),(7,3),
(8,2),(8,3),(8,5),
(9,2),(9,5),
(10,2),(10,4),
(11,4),(11,5),
(12,4),
(13,2),(13,4),
(14,4),
(15,3),(15,4);