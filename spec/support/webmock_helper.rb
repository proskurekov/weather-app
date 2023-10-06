module WebmockHelper
  def mock_request!(path, body)
    stub_request(:get, path).to_return(body: body)
  end
end
