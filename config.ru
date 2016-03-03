class Rapp
  def call(env)
    [
      200,
      {},
      [ 'CUAC' ]
    ]
  end
end

run Rapp.new
