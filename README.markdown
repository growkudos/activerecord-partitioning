# ActiveRecord partitioning
This gem enables ActiveRecord to understand partitioned tables in its schema.  At the moment this support is limited to MySQL and,
specifically, the mysql2 connection adapter.  *And, yes, this is very very alpha quality!*

Install with:

    gem 'activerecord-partitioning', git: 'https://github.com/growkudos/activerecord-partitioning', tag: '0.0.5'

Usage:

    class PartitionMyTable < ActiveRecord::Migration
      def up
        partition_table('my_table', 'PARTITION BY HASH(id)')
      end

      def down
        raise ActiveRecord::IrreversibleMigration, "Can't undo partitioning at the moment!")
      end
    end

The second parameter to `partition_table` is simply the MySQL partition statement at the moment, as that's all I needed.

Note that `rake db:schema:dump` will output the `partition_table` call for you.

Feel free to fork and submit pull requests.

## Update
- 2016-03 (Martyn Whitwell): updated to support Active Record 4 and support pseudo-composite primary keys.
- 2017-02 (Ryan Brooks): updated to support Active Record 5.