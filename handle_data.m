final_best_point=[462.6 394.99 805.08 216.81 1188.1 462.05 0.89115 0.48607 0.31926 0.13292 0.83688 2.9601 4.9771 4.2538 4.4673 2.4392 1.7509 0.065095 0.36827 1.7168 1.2908 8.0891 3.211 4.185 2.9159 1.3877 0.37072 0.34397 0.039556 1.4039 1.5336 1.5559 7.0905 2.774 7.1587 9.8383 129.03];
x=final_best_point;
iso_1_x=x(1);
iso_1_y=x(2);
iso_2_x=x(3);
iso_2_y=x(4);
iso_3_x=x(5);
iso_3_y=x(6);
iso_1_canshu=[iso_1_x,iso_1_y];
iso_2_canshu=[iso_2_x,iso_2_y];
iso_3_canshu=[iso_3_x,iso_3_y];
iso=[iso_1_canshu;iso_2_canshu;iso_3_canshu];
osi_1_airplane_number_send = int32(x(7:11));
osi_1_airplane_number_scan = int32(x(12:16));
osi_2_airplane_number_send = int32(x(17:21));
osi_2_airplane_number_scan = int32(x(22:26));
osi_3_airplane_number_send = int32(x(27:31));
osi_3_airplane_number_scan = int32(x(32:36));
rescue_time_sum = x(37);