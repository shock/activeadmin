module ActiveAdmin
  module Inputs
    module Filters
      class DateRangeInput < ::Formtastic::Inputs::StringInput
        include Base

        def to_html
          input_wrapping do
            [ label_html,
              builder.text_field(gt_input_name, input_html_options(gt_input_name)),
              template.content_tag(:span, "-", class: "seperator"),
              builder.text_field(lt_input_name, input_html_options(lt_input_name)),
            ].join("\n").html_safe
          end
        end

        def gt_input_name
          column && column.type == :date ? "#{method}_gteq" : "#{method}_gteq_datetime"
        end
        alias :input_name :gt_input_name

        def lt_input_name
          column && column.type == :date ? "#{method}_lteq" : "#{method}_lteq_datetime"
        end

        def input_html_options(input_name = gt_input_name)
          current_value = begin
            #cast value to date object before rendering input
            @object.public_send(input_name).to_s.to_date
          rescue 
            nil
          end
          { size: 12,
            class: "datepicker",
            maxlength: 10,
            value: current_value ? current_value.strftime("%Y-%m-%d") : "" }
        end
      end
    end
  end
end
