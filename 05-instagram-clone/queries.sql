-- =====================================================================
-- Instagram clone: queries
-- Run against the full dataset: data/ig_clone_data.sql
-- =====================================================================

USE ig_clone;

-- Photos posted by a given user
SELECT image_url FROM photos WHERE user_id = 1;

-- Same thing, with a subquery on users
SELECT image_url
FROM photos
WHERE user_id = (SELECT id FROM users WHERE username = 'Kenton_Kirlin');

-- Every photo with the username of its owner
SELECT image_url, username
FROM photos
JOIN users ON photos.user_id = users.id
ORDER BY username;

-- Users who never posted a photo (RIGHT JOIN keeps every user)
SELECT username
FROM photos
RIGHT JOIN users ON photos.user_id = users.id
WHERE photos.id IS NULL;
