module Elmas
  class SalesInvoice
    # An sales_invoice usually has multiple sales_invoice lines
    # It should also have a journal id and a contact id who ordered it
    include Elmas::Resource
    include Elmas::SharedSalesAttributes

    def initialize(attributes = {})
      super
      @attributes[:id] ||= @attributes[:invoice_id] if @attributes[:invoice_id]
    end

    def save
      super
      @attributes[:id] ||= @response.result.first.invoice_id
      @response
    end

    def base_path
      "salesinvoice/SalesInvoices"
    end

    def mandatory_attributes
      [:journal, :ordered_by]
    end

    def other_attributes
      SHARED_SALES_ATTRIBUTES.inject(
        [
          :sales_invoice_lines, :due_date, :sales_person,
          :starter_sales_invoice_status, :type
        ],
        :<<
      )
    end
  end
end
