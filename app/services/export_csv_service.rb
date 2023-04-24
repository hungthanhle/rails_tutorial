require "csv"

class ExportCsvService
  def initialize objects, attributes
    @attributes = attributes
    @objects = objects
    @header = attributes.map { |attr| I18n.t("header_csv.#{attr}") }
  end

  def perform_object
    CSV.generate do |csv|
      csv << header
      objects.each do |object|
        csv << attributes.map{ |attr| object.public_send(attr) }
      end
    end
  end

  def perform_array
    CSV.generate do |csv|
      csv << header
      objects.each do |array|
        csv << array
      end
    end
  end

  private
  attr_reader :attributes, :objects, :header
end
