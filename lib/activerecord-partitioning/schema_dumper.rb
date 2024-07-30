require 'active_support/concern'

module ActiveRecord
  module Partitioning
    module SchemaDumper
      extend ActiveSupport::Concern

      # Override the standard table dumping behaviour to include the partition
      # dumping
      def table(table, stream)
        super(table, stream)
        dump_partitions_of(table, stream)
        stream
      end

      # Dump the necessary Ruby code to partition the given table if it is
      # partitioned.
      def dump_partitions_of(table, stream)
        @connection.partition(table) do |partitioning_scheme|
          stream.puts(
            "  partition_table(#{table.inspect}, #{partitioning_scheme.inspect})"
          )
          stream.puts
        end
      end

      private :dump_partitions_of
    end
  end
end

# Uurggh. Have to include all of these for ActiveRecord::SchemaDumper
require 'active_record'
require 'active_record/base'
require 'active_record/schema_dumper'

module ActiveRecord
  class SchemaDumper
    prepend ActiveRecord::Partitioning::SchemaDumper
  end
end
