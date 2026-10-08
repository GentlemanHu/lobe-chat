-- Custom SQL migration file, put your code below! --
-- FORK FIX: pg_search is deprecated by Neon and can no longer be installed on
-- new Neon projects (ERROR 42501: extension "pg_search" is deprecated and no
-- longer allowed). Wrap the CREATE EXTENSION in a DO block so this migration
-- succeeds whether or not the extension can be created. When pg_search is
-- unavailable, set FTS_SEARCH_PROVIDER=pg_like (see
-- docs/self-hosting/advanced/neon-pg-search-migration.mdx).
DO $$
BEGIN
  CREATE EXTENSION IF NOT EXISTS pg_search;
EXCEPTION
  WHEN OTHERS THEN
    RAISE NOTICE 'pg_search extension could not be installed (%), skipping.', SQLERRM;
END
$$;
