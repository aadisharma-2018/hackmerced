//
//  AudioProcessing.m
//  vibToMusic
//
//  Created by Aadi Sharma on 3/9/24.
//

#import <Foundation/Foundation.h>

// AudioProcessing.m

//#import "AudioProcessing.h"
////#import <Python/Python.h>
//
//@implementation AudioProcessing
//
//- (NSArray *)butterLowpassFilterWithData:(NSArray *)data
//                                   cutoff:(double)cutoff
//                                       fs:(double)fs
//                                    order:(int)order {
//    // Convert NSArray to Python list
//    PyObject *pythonData = PyList_New([data count]);
//    for (int i = 0; i < [data count]; i++) {
//        NSNumber *number = [data objectAtIndex:i];
//        PyList_SetItem(pythonData, i, PyFloat_FromDouble([number doubleValue]));
//    }
//    
//    // Import Python module and call function
//    PyObject *pName = PyUnicode_DecodeFSDefault("audio_processing");
//    PyObject *pModule = PyImport_Import(pName);
//    PyObject *pFunc = PyObject_GetAttrString(pModule, "butter_lowpass_filter");
//    PyObject *pArgs = PyTuple_Pack(4, pythonData, PyFloat_FromDouble(cutoff), PyFloat_FromDouble(fs), PyLong_FromLong(order));
//    PyObject *pValue = PyObject_CallObject(pFunc, pArgs);
//    
//    // Convert result to NSArray
//    NSMutableArray *result = [NSMutableArray array];
//    for (int i = 0; i < PyList_Size(pValue); i++) {
//        PyObject *item = PyList_GetItem(pValue, i);
//        double value = PyFloat_AsDouble(item);
//        [result addObject:@(value)];
//    }
//    
//    // Clean up
//    Py_DECREF(pName);
//    Py_DECREF(pModule);
//    Py_DECREF(pFunc);
//    Py_DECREF(pArgs);
//    Py_DECREF(pValue);
//    
//    return result;
//}

//@end
