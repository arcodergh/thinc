from libc.stdint cimport int16_t, int32_t, uint64_t
from .typedefs cimport weight_t, atom_t


include "compile_time_constants.pxi"


cdef struct LayerC:
    void (*forward)(
        weight_t* activity,
        const weight_t* W,
        const weight_t* input_, 
        const weight_t* bias,
        int32_t nr_wide,
        int32_t nr_out
    ) nogil

    void (*backward)(
        weight_t* delta,
        weight_t* grad_W,
        weight_t* grad_b,
        const weight_t* W, 
        const weight_t* activity, 
        int32_t nr_wide, 
        int32_t nr_out
    ) nogil

    int32_t nr_wide
    int32_t nr_out


cdef struct EmbedC:
    int32_t offset
    int32_t nr


cdef struct SparseArrayC:
    int32_t key
    weight_t val


cdef struct FeatureC:
    int32_t slot
    uint64_t key
    weight_t val


cdef struct SparseAverageC:
    SparseArrayC* curr
    SparseArrayC* avgs
    SparseArrayC* times


cdef struct TemplateC:
    int[MAX_TEMPLATE_LEN] indices
    int length
    atom_t[MAX_TEMPLATE_LEN] atoms
