require 'swagger_helper'

describe 'histories API' do
  path '/rides' do
    get 'list of Histories your Rides' do
      tags 'rider'
      consumes 'application/json'
      parameter({
                  in: :header,
                  type: :string,
                  name: 'Authorization',
                  required: false,
                  description: 'user Barer token LATER'
                })

      parameter name: :per_page, in: :query, type: :string, required: false, example: 10
      parameter name: :page, in: :query, type: :string, required: true, example: 1

      response '200', 'Histories Success' do
        run_test!
      end

      response '401', 'unauthorized' do
        run_test!
      end
    end
    post 'Create new Ride' do
      tags 'rider'
      consumes 'application/json'
      parameter({
                  in: :header,
                  type: :string,
                  name: 'Authorization',
                  required: false,
                  description: 'user Barer token LATER'
                })
      parameter name: :ride, in: :body, schema: {
        type: :object,
        required: %w[email password],
        properties: {
          ride: {
            type: :object,
            description: 'user mail ',
            properties: {
              start_location: {
                type: :string,
                description: 'your name',
                example: '2222222,022222'
              },
              end_location: {
                type: :string,
                description: 'your name',
                example: '2222222,22222222'
              }
            }
          }
        }
      }

      response '200', 'Histories Success' do
        run_test!
      end

      response '401', 'unauthorized' do
        run_test!
      end
    end
  end
  path '/end_trip' do
    put 'Update your last trip by end ' do
      tags 'rider'
      consumes 'application/json'
      parameter({
                  in: :header,
                  type: :string,
                  name: 'Authorization',
                  required: false,
                  description: 'user Barer token LATER'
                })
      response '200', 'Histories Success' do
        run_test!
      end

      response '401', 'unauthorized' do
        run_test!
      end
    end
  end
end
