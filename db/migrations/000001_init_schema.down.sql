-- Drop foreign keys
ALTER TABLE "entries" DROP CONSTRAINT IF EXISTS fk_entries_account_id;
ALTER TABLE "transfers" DROP CONSTRAINT IF EXISTS fk_transfers_from_account_id;
ALTER TABLE "transfers" DROP CONSTRAINT IF EXISTS fk_transfers_to_account_id;

-- Drop indexes
DROP INDEX IF EXISTS idx_accounts_owner;
DROP INDEX IF EXISTS idx_entries_account_id;
DROP INDEX IF EXISTS idx_transfers_from_account_id;
DROP INDEX IF EXISTS idx_transfers_to_account_id;
DROP INDEX IF EXISTS idx_transfers_from_to_account_id;

-- Drop tables
DROP TABLE IF EXISTS "transfers";
DROP TABLE IF EXISTS "entries";
DROP TABLE IF EXISTS "accounts";
