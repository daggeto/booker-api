shared_examples 'event status changer' do
  it { has.to change { event.status }.to(status) }
end
