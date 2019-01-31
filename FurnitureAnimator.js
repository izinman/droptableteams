import React, {Component} from 'react';
import { Animated, Text, View } from 'react-native';
import StyleView from './StyleView';

type Props = {};
var opened = 0;
var arrow="^"
export default class FurnitureAnimator extends Component<Props> {
    constructor(props) {
        super(props);
        this.state = {
          visible: props.visible,
          scaleAnim: new Animated.Value(1),
          fadeAnim: new Animated.Value(0),  // Initial value for opacity: 0

        };
      };
  state = {
  }
  

  componentDidMount() {
                            // Starts the animation
    
    
  }
  drawerOpened = () => {
    if(opened == 0){
        Animated.timing(
            this.state.scaleAnim,            // The animated value to drive
            {
              toValue: .5,                   // Animate to opacity: 1 (opaque)
              duration: 300,              // Make it take a while
            }
        ).start();
        opened = 1
    }
    else{
        Animated.timing(
            this.state.scaleAnim,            // The animated value to drive
            {
              toValue: 1,                   // Animate to opacity: 1 (opaque)
              duration: 300,              // Make it take a while
            }
        ).start();
        opened = 0
    }
    
    console.log("Pressed jake");
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
                    outputRange: [-2150, 0]  // 0 : 150, 0.5 : 75, 1 : 0
                  })},
              ],
              
        }}
      >
      <StyleView onPress={this.drawerOpened}/>
            </Animated.View>
    );
  }
}