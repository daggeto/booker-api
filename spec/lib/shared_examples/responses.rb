shared_examples 'forbidden response' do
  it { is_expected.to be_forbidden }
end

shared_examples 'success response' do
  it { is_expected.to be_success }
end

shared_examples 'conflict response' do
  it { is_expected.to have_http_status(:conflict) }
end
