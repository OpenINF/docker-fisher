'use strict';

module.exports = function(context) {
  return {
    Program(node) {
      const {comments} = node;

      const comment = comments.find(c => c.value.includes('SPLIT_SINGLE_PASS'));
      if (!comment) {
        return;
      }

      context.report({
        node : comment,
        message :
            'Comments that contain "SPLIT_SINGLE_PASS" are reserved for single pass build',
      });
    },
  };
};
