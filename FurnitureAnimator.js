import React, {Component} from 'react';
import { Animated, Text, View, Dimensions} from 'react-native';
import StyleView from './StyleView';

type Props = {};
var opened = 1;
var arrow="^"
var {height, width} = Dimensions.get('window');
export default class FurnitureAnimator extends Component<Props> {
    constructor(props) {
        super(props);
        this.state = {
          visible: props.visible,
          scaleAnim: new Animated.Value(0),
          fadeAnim: new Animated.Value(0),  // Initial value for opacity: 0

        };
      };
  state = {
  }
  

  componentDidMount() {
                            // Starts the animation
    
    
  }
  drawerOpened = (e) => {
    if(e !='couch5' && e!='chair3'){
    if(opened == 0){
        Animated.timing(
            this.state.scaleAnim,            // The animated value to drive
            {
              toValue: 0,                   // Animate to opacity: 1 (opaque)
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
  }
  else{
    this.props.onPress(e)
    console.log(e);
  }
    
    
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
                    outputRange: [-height , 0]  // 0 : 150, 0.5 : 75, 1 : 0
                  })},
              ],
              
        }}
      >
      <StyleView onPress={this.drawerOpened}/>
            </Animated.View>
    );
  }
}