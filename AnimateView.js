import React, {Component} from 'react';
import { Animated, Text, View } from 'react-native';

type Props = {};

export default class AnimateView extends Component<Props> {
    constructor(props) {
        super(props);
        this.state = {
          visible: props.visible,
          scaleAnim: new Animated.Value(.25),
          fadeAnim: new Animated.Value(0),  // Initial value for opacity: 0

        };
      };
  state = {
  }
  

  componentDidMount() {
    Animated.timing(                  // Animate over time
      this.state.fadeAnim,            // The animated value to drive
      {
        toValue: 1,                   // Animate to opacity: 1 (opaque)
        duration: 200,              // Make it take a while
      },
      
    ).start();
                            // Starts the animation
    Animated.timing(
        this.state.scaleAnim,            // The animated value to drive
        {
          toValue: 1,                   // Animate to opacity: 1 (opaque)
          duration: 300,              // Make it take a while
        }
    ).start();
    
  }


  render() {
    let { fadeAnim } = this.state;
    let { scaleAnim } = this.state;

    return (
      <Animated.View                 // Special animatable View
        style={{
            transform: [{
                translateY: this.state.scaleAnim.interpolate({
                    inputRange: [0, 1],
                    outputRange: [100, 0]  // 0 : 150, 0.5 : 75, 1 : 0
                  })},
              ],
          opacity: this.state.fadeAnim,      // Bind opacity to animated value
        }}
      >
        {this.props.children}
      </Animated.View>
    );
  }
}