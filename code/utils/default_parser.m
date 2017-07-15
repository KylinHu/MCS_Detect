function input_parser = default_parser()
% Parse input parameters. Set default value.
% TODO: add check function
input_parser = inputParser;
input_parser.addRequired('input_dir');
input_parser.addRequired('output_dir');

% rewrite options, for efficient running.
% if is_rewrite == true, compulsively set is_track_rewrite = true and
% is_mark_rewrite = true, is_IR_rewrite = true
input_parser.addParameter('is_rewrite', false);
input_parser.addParameter('is_IR_rewrite', false);
input_parser.addParameter('is_mark_rewrite', false);
input_parser.addParameter('is_track_rewrite', false);
input_parser.addParameter('is_MCS_rewrite', true);
input_parser.addParameter('is_MCStxt_rewrite', false);
% Options of tracking methods
% pure area-overlapping method---'overlapping'; pure Kalman Filter--'KF';
% use 'KF' based on 'OL' -- 'TO'
input_parser.addParameter('tracking_method', 'TO'); 

% flag_core_only
input_parser.addParameter('flag_core_only', true);

input_parser.addParameter('shield_temperature_threshold', 233);
input_parser.addParameter('shield_area_threshold', 5000);
input_parser.addParameter('core_temperature_threshold', 233);
input_parser.addParameter('core_area_threshold', 5000);



% Object region -- entire tropics(30N~30S):latitude;longitude
input_parser.addParameter('x1', 180);
input_parser.addParameter('x2', 360);
input_parser.addParameter('y1', 1);
input_parser.addParameter('y2', 1080);
% Object month 
time_list = task_assign(1986, 1, 1986, 1, 1, 1);%array_size, array_id
input_parser.addParameter('interest_date_begin', time_list.interest_begin_date);
input_parser.addParameter('interest_date_end', time_list.interest_end_date);
input_parser.addParameter('record_date_begin', time_list.record_begin_date);
input_parser.addParameter('record_date_end', time_list.record_begin_date);
% example: records for MCS generated in Jan 1986
% input_parser.addParameter('interest_date_begin', '01-Dec-1985');
% input_parser.addParameter('interest_date_end', '28-Feb-1986');
% input_parser.addParameter('record_date_begin', '01-Jan-1986');
% input_parser.addParameter('record_date_end', '31-Jan-1986');



% Overlapping rate threshold, percentage
input_parser.addParameter('overlapping_rate_threshold', 15);
% Kalman Filter parameters, units based on pixel
input_parser.addParameter('KF_distance_threshold', 25); 
input_parser.addParameter('init_loc_var', 1);
input_parser.addParameter('init_v_var', 3);
input_parser.addParameter('noise_loc_var', 3);
input_parser.addParameter('noise_v_var', 3);
input_parser.addParameter('detect_loc_var', 1);

% Persistence time, from number of snapshot
input_parser.addParameter('age_threshold', 1);
input_parser.addParameter('core_age_threshold', 1);

% if is_use_pixel == true, use pixel as coverage area unit;
% otherwise, use km^2 as area unit.
input_parser.addParameter('is_use_pixel', false);

% 
input_parser.addParameter('invisible_count_threshold', 0);
end
