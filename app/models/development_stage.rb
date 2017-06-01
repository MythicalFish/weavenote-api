class DevelopmentStage < ActiveHash::Base
  self.data = [
    { id: 1, label: 'Sample' },
    { id: 2, label: 'Production' },
    { id: 3, label: 'Done' },
  ]
end
