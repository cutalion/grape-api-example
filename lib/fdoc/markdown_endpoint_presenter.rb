require 'fdoc'

module Fdoc
  class MarkdownEndpointPresenter < EndpointPresenter
    def to_markdown
      <<-MARKDOWN
        # Description:

        #{description}

        # Example request:

        #{example_request}

        # Example response:

        #{example_response}

        # Response codes:

        ## Successfull response codes:

        #{successful_response_codes}

        ## Failure response codes:

        #{failure_response_codes}

        # Response parameters

        #{response_parameters}
      MARKDOWN
    end

    def description
      render_lines endpoint.description.split("\n")
    end

    def example_request
      render_json example_from_schema(endpoint.request_parameters).except('api_key')
    end

    def example_response
      render_json example_from_schema(endpoint.response_parameters)
    end

    def response_parameters
      response_parameters = endpoint.response_parameters
      lines = []

      if response_parameters["type"].eql? "array"
        description = response_parameters['items']['description']
        lines << "## #{description}"
        lines += params_to_markdown response_parameters['items']['properties']
      else
        lines = params_to_markdown response_parameters['properties']
      end
      render_lines lines
    end

    def params_to_markdown(properties)
      properties.map do |name, props|
        <<-PARAM.strip
          * `#{name}` (#{props['type']}) #{props['required'] ? '**required**' : '_optional_'}   
            #{props['description']}
        PARAM
      end
    end

    def successful_response_codes
      render_codes(super)
    end

    def failure_response_codes
      render_codes(super)
    end

    def render_codes(codes)
      codes = codes.map do |code|
        "`#{code.status}` - #{code.response_code['description']}"
      end
      render_lines codes
    end

    def render_lines(lines)
      Array(lines).join("\n\r")
    end

    def render_json(json)
      "\t" + JSON.pretty_generate(json).gsub("\n", "\n\r\t")
    end
  end
end
