//
//  AudioProcessing.h
//  vibToMusic
//
//  Created by Aadi Sharma on 3/9/24.
//

#ifndef AudioProcessing_h
#define AudioProcessing_h

// AudioProcessing.h

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AudioProcessing : NSObject

- (NSArray *)butterLowpassFilterWithData:(NSArray *)data
                                   cutoff:(double)cutoff
                                       fs:(double)fs
                                    order:(int)order;

@end

NS_ASSUME_NONNULL_END



#endif /* AudioProcessing_h */
