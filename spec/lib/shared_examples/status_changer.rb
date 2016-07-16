shared_examples 'status changer' do
  it { has.to change { event.status }.to(status) }
end
