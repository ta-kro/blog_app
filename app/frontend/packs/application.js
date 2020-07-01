import 'stylesheets/application';
import 'javascripts/application';
require.context('../images', true, /\.(png|jpg|jpeg|svg)$/);

import Rails from 'rails-ujs';
Rails.start();
