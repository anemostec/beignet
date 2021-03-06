kernel void __cl_copy_image_1d_array_to_1d_array(__read_only image1d_array_t src_image, __write_only image1d_array_t dst_image,
                             unsigned int region0, unsigned int region1, unsigned int region2,
                             unsigned int src_origin0, unsigned int src_origin1, unsigned int src_origin2,
                             unsigned int dst_origin0, unsigned int dst_origin1, unsigned int dst_origin2)
{
  int i = get_global_id(0);
  int k = get_global_id(2);
  int4 color;
  const sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_NONE | CLK_FILTER_NEAREST;
  int2 src_coord;
  int2 dst_coord;
  if((i >= region0) || (k>=region2))
    return;

  src_coord.x = src_origin0 + i;
  src_coord.y = src_origin2 + k;
  dst_coord.x = dst_origin0 + i;
  dst_coord.y = dst_origin2 + k;
  color = read_imagei(src_image, sampler, src_coord);
  write_imagei(dst_image, dst_coord, color);
}
